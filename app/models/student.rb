# frozen_string_literal: true

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :group, optional: true
  before_update :check_if_removing_from_group
  before_destroy :check_if_head_student

  has_one_attached :avatar

  has_many :student_subject_opt_outs

  has_many :student_attendances, dependent: :destroy

  has_many :student_task_scores
  has_many :tasks, through: :student_task_scores

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def check_if_head_student
    return unless group&.head_student == self

    errors.add(:base, 'Cannot remove the head student from the group')
    throw :abort
  end

  def check_if_removing_from_group
    return unless group_id_changed? && group_id_was && Group.find(group_id_was).head_student == self

    errors.add(:base, 'Cannot change the group of the head student directly')
    throw :abort
  end

  def self.ransackable_associations(_auth_object = nil)
    ["avatar_attachment", "avatar_blob", "group", "profile"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["city", "country", "created_at", "email", "encrypted_password", "first_name", "group_id", "id", "last_name", "remember_created_at",
     "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
