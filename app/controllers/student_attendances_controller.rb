class StudentAttendancesController < ApplicationController

  def edit
    @schedule = Schedule.find(params[:id])
    @schedules = Schedule.order(:time)
    @previous_schedule = previous_schedule(@schedule)
    @next_schedule = next_schedule(@schedule)
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedules = Schedule.order(:time)

    if params[:attendance_submitted]
      submitted_attendance_params = attendance_params || {}

      Student.all.each do |student|
        if submitted_attendance_params[student.id.to_s] == '1'
          StudentAttendance.find_or_create_by(schedule_id: @schedule.id, student_id: student.id)
        else
          StudentAttendance.where(schedule_id: @schedule.id, student_id: student.id).destroy_all
        end
      end

      render :edit, notice: "Attendance updated successfully."
    else
      render :edit, alert: "No attendance data submitted."
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit!
  rescue ActionController::ParameterMissing
    {}
  end

  def previous_schedule(current_schedule)
    Schedule.where("time < ?", current_schedule.time).order(time: :desc).first
  end

  def next_schedule(current_schedule)
    Schedule.where("time > ?", current_schedule.time).order(:time).first
  end
end
