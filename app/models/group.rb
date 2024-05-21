class Group < ApplicationRecord
	# belongs_to :teacher
	belongs_to :head_student, class_name: 'Student', optional: true
	has_many :students, dependent: :destroy
	# has_many :students, through: :group_students

	has_many :group_schedule, dependent: :destroy
	has_many :schedules, through: :group_schedule

	validates :name, presence: true
	validate :head_student_belongs_to_group
	# validates :teacher, presence: true

	# accepts_nested_attributes_for :group_students

	private

	def head_student_belongs_to_group
		errors.add(:head_student, "must be a member of this group") unless head_student.nil? || students.include?(head_student)
	end
end
