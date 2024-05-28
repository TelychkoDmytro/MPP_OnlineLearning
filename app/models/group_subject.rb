# frozen_string_literal: true

class GroupSubject < ApplicationRecord
  belongs_to :group
  belongs_to :subject

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "group_id", "id", "subject_id", "updated_at"]
  end
end
