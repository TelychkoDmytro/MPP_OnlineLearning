# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :subject_teacher, dependent: :destroy
  has_many :teachers, through: :subject_teacher
  belongs_to :head_teacher, class_name: 'Teacher'

  has_many :group_subject, dependent: :destroy
  has_many :groups, through: :group_subject

  has_many :tasks, dependent: :destroy

  has_many :schedules

  validate :head_teacher_in_teachers_list

  before_validation :add_first_teacher_as_head_teacher

	validates :name, presence: true, uniqueness: true

	has_many :student_subject_opt_outs

  private

  def head_teacher_in_teachers_list
    return if teachers.include?(head_teacher)

    errors.add(:head_teacher, "must be one of the subject's teachers")
  end

  def add_first_teacher_as_head_teacher
    return unless teachers.empty? && head_teacher.present?

    teachers << head_teacher
  end

  def self.ransackable_associations(_auth_object = nil)
    ["group_subject", "groups", "head_teacher", "schedules", "subject_teacher", "tasks", "teachers"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "head_teacher_id", "id", "name", "updated_at"]
  end
end
