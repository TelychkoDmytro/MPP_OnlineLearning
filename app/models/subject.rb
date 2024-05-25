class Subject < ApplicationRecord

	has_many :subject_teacher, dependent: :destroy
	has_many :teachers, through: :subject_teacher
	belongs_to :head_teacher, class_name: "Teacher"

	has_many :group_subject, dependent: :destroy
	has_many :groups, through: :group_subject

	has_many :scores, dependent: :destroy
	has_many :students, through: :scores

	has_many :schedules

	validates :name, presence: true, uniqueness: true
	validates :head_teacher, presence: true

validate :head_teacher_in_teachers_list

  before_validation :add_first_teacher_as_head_teacher, on: :create

private

  def head_teacher_in_teachers_list
    unless teachers.include?(head_teacher)
      errors.add(:head_teacher, "must be one of the subject's teachers")
    end
  end

  def add_first_teacher_as_head_teacher
    if teachers.empty? && head_teacher.present?
      teachers << head_teacher
    end
  end
end
