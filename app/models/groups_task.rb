# frozen_string_literal: true

class GroupsTask < ApplicationRecord
  belongs_to :group
  belongs_to :task
end
