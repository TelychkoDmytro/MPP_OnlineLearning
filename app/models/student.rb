class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # has_many :group_students, dependent: :destroy
  # has_many :groups, through: :group_students
  belongs_to :group, optional: true
  before_destroy :check_if_head_student
  before_update :check_if_removing_from_group

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :scores, dependent: :destroy
  has_many :subjects, through: :scores

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def check_if_head_student
    if group&.head_student == self
      errors.add(:base, "Cannot remove the head student from the group")
      throw :abort
    end
  end

  def check_if_removing_from_group
    if group_id_changed? && group_id_was && Group.find(group_id_was).head_student == self
      errors.add(:base, "Cannot change the group of the head student directly")
      throw :abort
    end
  end
end
