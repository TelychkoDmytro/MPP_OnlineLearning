class SubjectsController < ApplicationController
  before_action :authenticate_teacher!, except: [:index, :show]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    if student_signed_in?
      @subjects = current_student.subjects
    elsif teacher_signed_in?
      @subjects = current_teacher.subjects
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    if teacher_signed_in?
      @subject = current_teacher.subjects.build(subject_params)
    end

    if @subject.save
      redirect_to @subject, notice: 'Subject was successfuly created'
    else
      render :new
    end
  end

  def show
    # Rails.logger.debug "Subject: #{@subject.teachers.inspect}"
  end

  def edit
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end
