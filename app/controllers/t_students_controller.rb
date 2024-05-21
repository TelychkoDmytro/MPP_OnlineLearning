class TStudentsController < ApplicationController
  before_action :authenticate_teacher!, except: [:edit, :index, :show]
  before_action :set_student, only: [:edit, :update]
  before_action :check_access_for_edit, only: [:edit]

  def index
    # @students = Student.where(group_id: nil)
    @students = Student.all
  end

  def show
    # unless current_teacher.nil? and (current_student.nil?)
    if student_signed_in?
      if current_student.id == @student.id
        @student = Student.find(params[:id])
      end
    else
      puts "Acces denied"
    end
  end

  def edit
    Rails.logger.info "#{@student.inspect}"
  end

  def update
    if @student.update(student_params)
      redirect_to t_students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:id, :first_name, :last_name, :group_id)
  end

  def check_access_for_edit
    if student_signed_in?
      flash[:alert] = "Access denied"
      redirect_to t_students_path
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
