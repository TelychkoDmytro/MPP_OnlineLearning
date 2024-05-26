class SubjectTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validates_uniqueness_of :subject_id, :scope => [:teacher_id]
end
