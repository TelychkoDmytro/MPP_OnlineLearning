class GroupsController < ApplicationController
  def index
    if student_signed_in?
      @groups = current_student.groups
    elsif teacher_signed_in?
      @groups = current_teacher.groups
    else
      puts "Error"
    end
  end

  def new
    @group = Group.new
  end

  def create
    # @group = current_user.groups.build(group_params)

    if student_signed_in?
      @group = current_student.groups.build(group_params)
    elsif teacher_signed_in?
      @group = current_teacher.groups.build(group_params)
    end

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name, :head_student_id)
  end
end
