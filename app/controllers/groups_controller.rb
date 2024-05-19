class GroupsController < ApplicationController
  # before_action :authenticate_student!, except: [:index, :show]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @students = Student.all
  end

  def create
    @group = Group.all.build(group_params)

    if @group.save
      # @group.students << Student.where(id: params[:group][:stuent_ids])
      redirect_to @group, notice: 'Group was successfully created.'
    else
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
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to @group, notice: 'Group was deleted'
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
