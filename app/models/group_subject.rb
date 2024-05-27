# frozen_string_literal: true

class GroupSubject < ApplicationRecord
  belongs_to :group
  belongs_to :subject
end
