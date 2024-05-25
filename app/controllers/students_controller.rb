class StudentsController < ApplicationController
	before_action :authenticate_teacher!, only: [:edit, :update]
	before_action :set_student, only: [:edit, :update]
	before_action :check_access_for_edit, only: [:edit]

	def index
		@students = Student.all
	end

	def edit
	end

	def update
		Rails.logger.info "#{@student.inspect}"
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
			flash[:alert] = "Access denied"
			redirect_to students_path
		elsif teacher_signed_in?
		  # Allow access to the edit action if the teacher is signed in
		  authenticate_teacher!
		else
		  # Handle the case where no user is signed in
		  flash[:notice] = "You need to sign in as a teacher to access this page"
		  redirect_to new_teacher_session_path
		end
	end
end
