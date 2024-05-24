class SchedulesController < ApplicationController
  before_action :authenticate_teacher, only: [:edit, :new, :destroy]
  before_action :atuhencticate, except: [:index, :show]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  

  def index
    @schedules = Schedule.all
  end

  def show
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path
    else
      render :edit
    end
  end

  def destroy
    if @schedule.destroy
      redirect_to @schedule, notice: 'Schedule was canceled'
    end
  end

  def new
    @schedule = Schedule.new
  end

  def create
    Rails.logger.info "Schedule Params: #{params[:schedule].inspect}"

    @schedule = Schedule.new(schedule_params)
    
    Rails.logger.info "Schedule After Init: #{@schedule.inspect}"

    if @schedule.save
      Rails.logger.info "Schedule Saved: #{@schedule.inspect}"
      redirect_to schedules_path, notice: "Schedule was successfully created."
    else
      Rails.logger.info "Schedule Save Errors: #{@schedule.errors.full_messages}"
      render :new
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:time, :teacher_id, :subject_id, :schedule_type, group_ids: [])
  end

  def atuhencticate
    unless student_signed_in? or teacher_signed_in?
      redirect_to login_path, notice: "You need to be signed in"
    end
  end

  def authenticate_teacher
    if student_signed_in?
      flash[:alert] = "Access denied. Only teachers can create and add schedules"
      redirect_to schedules_path
    elsif teacher_signed_in?
      authenticate_teacher!
    end
  end
end
