# frozen_string_literal: true

class StudentSubjectOptOut < ApplicationRecord
  belongs_to :student
  belongs_to :subject
end
