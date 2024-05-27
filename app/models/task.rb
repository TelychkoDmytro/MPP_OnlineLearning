# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :groups
  belongs_to :subject

  validate :groups_must_belong_to_subject
  validates :title, presence: true
  validates :description, presence: true
  validates :max_score, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 100}
  validates :earned_score, numericality: {only_integer: true, greater_than_or_equal_to: 0 }
  validate :max_score_uniqueness_within_group_and_subject

  private

  def groups_must_belong_to_subject
    invalid_groups = groups.reject { |group| group.subjects.include?(subject) }
    if invalid_groups.any?
      errors.add(:groups, "must be associated with the subject")
    end
  end

  def max_score_uniqueness_within_group_and_subject
    groups.each do |group|
      sum_max_scores = Task.joins(:groups)
      .where(subject: subject, groups: { id: group.id })
      .where.not(id: id)
      .sum(:max_score)

      if sum_max_scores >= 100
        errors.add(:max_score, "sum of max scores for the same group and subject cannot exceed 100")
      end
    end

  end
end
