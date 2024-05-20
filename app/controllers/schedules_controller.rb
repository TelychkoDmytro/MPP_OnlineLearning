class SchedulesController < ApplicationController
  before_action :authenticate_teacher!, except: [:index, :show]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  

  def index
    @schedules = Schedule.all
  end

  def show
  end

  def edit
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      redirect_to schedules_path, notice: "Schedule was successfully created."
    else
      Rails.logger.info "#{@schedule.inspect}"
      render :new
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:time, :teacher_id, :subject_id)
  end
end
