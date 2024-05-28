class StudentTaskScore < ApplicationRecord
  belongs_to :student
  belongs_to :task

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :score_less_than_or_equal_to_max_score

  private

  def score_less_than_or_equal_to_max_score
    if score.present? and task.present? and score > task.max_score
      errors.add(:score, "must be less than or equal to the maximum score of #{task.max_score}")
    end
  end
end
