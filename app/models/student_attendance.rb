# frozen_string_literal: true

class StudentAttendance < ApplicationRecord
  belongs_to :student
  belongs_to :schedule
end
