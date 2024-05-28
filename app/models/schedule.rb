# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  has_many :group_schedule, dependent: :destroy
  has_many :groups, through: :group_schedule

  validate :teacher_must_teach_subject
  validates :schedule_type, inclusion: {in: ['lecture', 'practic']}

  validates :schedule_type, presence: true
  # validates :group_ids, presence: true

  has_many :student_attendances, dependent: :destroy

  private

  def teacher_must_teach_subject
    unless teacher.nil?
      unless teacher.subjects.include?(subject)
        errors.add(:teacher, "must be authorized to teach this subject!")
      end
    end
  end
end
