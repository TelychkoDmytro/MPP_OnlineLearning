class TStudentsController < ApplicationController
  before_action :authenticate_teacher!, except: [:index, :show]
  before_action :set_student, only: [:edit, :update]

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
      puts 
    end
  end

  def edit
  end

  def update
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
    params.require(:student).permit(:id, :first_name, :last_name, :group_id)
  end
end
