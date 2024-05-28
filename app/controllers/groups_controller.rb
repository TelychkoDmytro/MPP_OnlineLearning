# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticate, except: [:show]
  before_action :check_rights, only: [:show]

  def index
    return unless teacher_signed_in?

    @groups = Group.joins(:subjects).where(subjects: { id: current_teacher.subject_ids }).distinct
  end

  def show
    @students = @group.students
  end

  def new
    @group = Group.new
    @students = Student.all
  end

  def edit; end

  def create
    @group = Group.all.build(group_params)

    if @group.save
      # @group.students << Student.where(id: params[:group][:stuent_ids])
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    return unless @group.destroy

    redirect_to @group, notice: 'Group was deleted'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :head_student_id, student_ids: [], schedule_ids: [])
  end

  def authenticate
    if student_signed_in?
      flash[:alert] = 'Access denied'
      redirect_to root_path
    elsif teacher_signed_in?
      authenticate_teacher!
    else
      flash[:notice] = 'You need to sign in as a teacher to access this page'
      redirect_to new_teacher_session_path
    end
  end

  def check_rights
    return if student_signed_in? || teacher_signed_in?

    flash[:notice] = 'You need to sign in to access this page'
    redirect_to login_path
  end
end
