# frozen_string_literal: true

class SubjectTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validates :subject_id, uniqueness: { scope: [:teacher_id] }

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "subject_id", "teacher_id", "updated_at"]
  end
end
