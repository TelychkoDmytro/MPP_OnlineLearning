class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  after_create :create_student_profile

  validates :first_name, presence: true
  validates :last_name, presence: true

  private

  def create_student_profile
    self.create_profile
  end
end
