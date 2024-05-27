# frozen_string_literal: true

class SubjectsController < ApplicationController
  before_action :authenticate, except: [:index, :show, :all_subjects]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    if student_signed_in?
      @subjects = current_student.group.subjects
    elsif teacher_signed_in?
      @subjects = current_teacher.subjects
    end
  end

  def all_subjects
    @subjects = Subject.all
  end

  def show
    # Rails.logger.debug "Subject: #{@subject.teachers.inspect}"
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    if teacher_signed_in?
      @subject = current_teacher.subjects.build(subject_params)
    end

    if @subject.save
      redirect_to @subject, notice: 'Subject was successfuly created'
    else
      flash.now[:alert] = "Subject '#{subject_params[:name]}' already exists."
      render :new
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to @subject
    else
      render :edit
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :head_teacher_id, teacher_ids: [], student_ids: [], group_ids: [])
  end

  def authenticate
    unless teacher_signed_in?
      authenticate_teacher!
    end
  end
end
