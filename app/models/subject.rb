class Subject < ApplicationRecord

	has_many :subject_teacher, dependent: :destroy
	has_many :teachers, through: :subject_teacher

	has_many :schedules
end
