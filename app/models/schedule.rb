class Schedule < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validate :teacher_must_teach_subject

  private

  def teacher_must_teach_subject
    unless teacher.nil?
      unless teacher.subjects.include?(subject)
        errors.add(:teacher, "must be authorized to teach this subject!")
      end
    end
  end
end
