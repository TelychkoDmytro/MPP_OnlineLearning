class GroupsController < ApplicationController
  before_action :authenticate_teacher!, except: [:index, :show, :edit]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :check_access_for_index_and_new, only: [:index, :new]
  before_action :check_access_for_edit, only: [:edit]
  
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
    params.require(:group).permit(:name, :head_student_id, student_ids: [], schedule_ids: [])
  end

  def check_access_for_index_and_new
    if student_signed_in?
      flash[:alert] = "Access denied"
      redirect_to root_path
    elsif teacher_signed_in?
      authenticate_teacher!
    else
      flash[:notice] = "You need to sign in as a teacher to access this page"
      redirect_to new_teacher_session_path
    end
  end

  def check_access_for_edit
    if student_signed_in?
      unless current_student.group.head_student_id = current_student.id
        flash[:alert] = "Access denied"
      end
    elsif teacher_signed_in?
      authenticate_teacher!
    else
      flash[:notice] = "You need to sign in to access this page"
      redirect_to login_path
    end
  end
end
