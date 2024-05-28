# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, except: %i[index new create]
  before_action :authenticate

  def index
    @subject = Subject.find(params[:subject_id])
    @tasks = @subject.tasks
  end

  def show; end

  def new
    @subject = Subject.find(params[:subject_id])
    @task = Task.new
    @task.subject = @subject
  end

  def edit; end

  def create
    @subject = Subject.find(params[:subject_id])
    @task = Task.new(task_params)
    @task.subject = @subject
    if @task.save
      redirect_to subject_task_path(@subject, @task), notice: 'Task was successfully craete.'
    else
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :subject_id, :max_score, :earned_score, group_ids: [])
  end

  def authenticate
    return if teacher_signed_in? || student_signed_in?

    flash[:notice] = 'You need to sign in as a teacher to access this page'
    redirect_to new_teacher_session_path
  end
end
