# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  has_many :group_schedule, dependent: :destroy
  has_many :groups, through: :group_schedule

  validate :teacher_must_teach_subject
  validates :schedule_type, inclusion: { in: ['lecture', 'practic'] }

  validates :schedule_type, presence: true
  # validates :group_ids, presence: true

  has_many :student_attendances, dependent: :destroy

  private
  def teacher_must_teach_subject
    return if teacher.nil?
    return if teacher.subjects.include?(subject)

    errors.add(:teacher, 'must be authorized to teach this subject!')
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "schedule_type", "subject_id", "teacher_id", "time", "updated_at"]
  end

  require 'csv'
  def self.to_csv
    schedules = all

    attributes = %w{id, subject_id, teacher_id, time, schedule_type}

    CSV.generate(headers: true) do |csv|
      csv << column_names

      schedules.find_each do |schedule|
        csv << schedule.attributes.values_at(*column_names)
        # csv << attributes.map{ |attr| schedule.send(attr) }
      end
    end
  end
end
