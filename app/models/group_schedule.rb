# frozen_string_literal: true

class GroupSchedule < ApplicationRecord
  belongs_to :group
  belongs_to :schedule
end
