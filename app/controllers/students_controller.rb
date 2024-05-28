# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :authenticate_teacher!, only: %i[edit update]
  before_action :set_student, only: %i[edit update]
  before_action :check_access_for_edit, only: [:edit]

	def opt_out_subjects
		@student = current_student
		@subjects = current_student.group.subjects
	end

	def update_opt_out_subjects
	    @student = current_student
	    @student.student_subject_opt_outs.destroy_all # Clear existing opt-outs

	    subject_ids = params[:student][:subject_ids].reject(&:blank?)
	    subject_ids.each do |subject_id|
	      StudentSubjectOptOut.create(student: @student, subject_id: subject_id)
	    end

	    redirect_to root_path, notice: "Opt-out preferences updated successfully."
	  end

	def index
		@students = Student.all
	end

  def edit; end

  def update
    Rails.logger.info @student.inspect.to_s
    if @student.update(student_params)
      redirect_to students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:email, :first_name, :last_name, :bio, :group_id, :avatar, :city, :country)
  end

  def check_access_for_edit
    if student_signed_in?
      flash[:alert] = 'Access denied'
      redirect_to students_path
    elsif teacher_signed_in?
      # Allow access to the edit action if the teacher is signed in
      authenticate_teacher!
    else
      # Handle the case where no user is signed in
      flash[:notice] = 'You need to sign in as a teacher to access this page'
      redirect_to new_teacher_session_path
    end
  end
end
