class GroupsController < ApplicationController
  before_action :authenticate_student!, except: [:index, :show]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  
  def index
    if student_signed_in?
      @groups = Group.all
    end
  end

  def new
    @group = Group.new
    @students = Student.all
  end

  def create
    # @group = current_user.groups.build(group_params)

    if student_signed_in?
      @group = current_student.groups.build(group_params)
    elsif teacher_signed_in?
      @group = current_teacher.groups.build(group_params)
    end

    if @group.save
      @group.students << Student.where(id: params[:group][:stuent_ids])
      redirect_to @group, notice: 'Group was successfully created.'
    else
      @students = Student.all
      render :new
    end
  end

  def show
    @students = @group.students
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated'
    else
      render :edit
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :head_student_id, student_ids: [])
  end
end
