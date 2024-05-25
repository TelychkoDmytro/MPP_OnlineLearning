class TasksController < ApplicationController
  before_action :set_task, except: [:index]
  before_action :authenticate

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  def new
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :student_id, :subject_id, :max_score, :earned_score)
  end

  def authenticate
    unless teacher_signed_in? or student_signed_in?
      flash[:notice] = "You need to sign in as a teacher to access this page"
      redirect_to new_teacher_session_path
    end
  end
end
