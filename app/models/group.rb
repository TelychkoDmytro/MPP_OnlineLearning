class Group < ApplicationRecord
	belongs_to :teacher
	belongs_to :head_student, class_name: 'Student', optional: true
	has_many :group_students
	has_many :students, through: :group_students

	validates :name, presence: true
	validates :teacher, presence: true
end
