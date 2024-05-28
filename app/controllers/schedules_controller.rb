# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :authenticate_teacher, only: %i[edit new destroy]
  before_action :atuhencticate, except: %i[index show]
  before_action :set_schedule, only: %i[show edit update destroy]


  def index
    @schedules = Schedule.all

    respond_to do |format|
      format.html
      format.csv {send_data @schedules.to_csv, filename: "schedules-#{Date.today}.csv"}
    end
  end

  def show; end

  def new
    @schedule = Schedule.new
  end

  def edit; end

  def create
    Rails.logger.info "Schedule Params: #{params[:schedule].inspect}"

    @schedule = Schedule.new(schedule_params)

    Rails.logger.info "Schedule After Init: #{@schedule.inspect}"

    if @schedule.save
      Rails.logger.info "Schedule Saved: #{@schedule.inspect}"
      redirect_to schedules_path, notice: 'Schedule was successfully created.'
    else
      Rails.logger.info "Schedule Save Errors: #{@schedule.errors.full_messages}"
      render :new
    end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path
    else
      render :edit
    end
  end

  def destroy
    return unless @schedule.destroy

    redirect_to @schedule, notice: 'Schedule was canceled'
  end


  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:time, :teacher_id, :subject_id, :schedule_type, group_ids: [])
  end

  def atuhencticate
    return if student_signed_in? || teacher_signed_in?

    redirect_to login_path, notice: 'You need to be signed in'
  end

  def authenticate_teacher
    if student_signed_in?
      flash[:alert] = 'Access denied. Only teachers can create and add schedules'
      redirect_to schedules_path
    elsif !teacher_signed_in?
      authenticate_teacher!
    end
  end
end
