# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :groups
  belongs_to :subject

  validate :groups_must_belong_to_subject
  validates :title, presence: true
  validates :description, presence: true
  validates :max_score, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 100}
  validate :max_score_uniqueness_within_group_and_subject

  has_many :student_task_scores
  has_many :students, through: :student_task_scores

  after_create :create_student_task_scores

  def create_student_task_scores
    groups.each do |group|
      group.students.each do |student|
        StudentTaskScore.create(task: self, student: student, score: 0)
      end
    end
  end

  def groups_must_belong_to_subject
    invalid_groups = groups.reject { |group| group.subjects.include?(subject) }
    return unless invalid_groups.any?

    errors.add(:groups, 'must be associated with the subject')
  end

  def max_score_uniqueness_within_group_and_subject
    groups.each do |group|
      sum_max_scores = group.tasks.where.not(id: id).sum(:max_score)
      if sum_max_scores + max_score > 100
        errors.add(:max_score, 'sum of max scores for the same group and subject cannot exceed 100')
        break
      end
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "description", "id", "max_score", "subject_id", "title", "updated_at"]
  end
end
