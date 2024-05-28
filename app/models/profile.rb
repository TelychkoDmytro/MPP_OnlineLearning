# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :student

  def self.ransackable_associations(_auth_object = nil)
    ["student"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["bio", "created_at", "id", "student_id", "updated_at"]
  end
end
