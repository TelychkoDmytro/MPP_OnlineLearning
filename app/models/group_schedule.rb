# frozen_string_literal: true

class GroupSchedule < ApplicationRecord
  belongs_to :group
  belongs_to :schedule

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "group_id", "id", "schedule_id", "updated_at"]
  end
end
