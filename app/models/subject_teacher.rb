# frozen_string_literal: true

class SubjectTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validates :subject_id, uniqueness: { :scope => [:teacher_id] }
end
