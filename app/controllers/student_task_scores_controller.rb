class StudentTaskScoresController < ApplicationController
  before_action :set_task
  before_action :set_student_task_score, only: [:edit, :update]

  def edit
  end

  def update
    if @student_task_score.update(student_task_score_params)
      redirect_to subject_task_path(@task.subject, @task), notice: 'Score was successfully updated.'
    else
      flash.now[:alert] = "Score must be less than or equal to the maximum score of #{@task.max_score}."
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_student_task_score
    @student_task_score = StudentTaskScore.find(params[:id])
  end

  def student_task_score_params
    params.require(:student_task_score).permit(:score)
  end
end
