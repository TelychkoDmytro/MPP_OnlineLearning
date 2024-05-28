# frozen_string_literal: true

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom validation using regex
  # validates :email, format: { with: /\A[^@\s]+@karazin\.ua\z/, message: "must be a karazin.ua email address" }
  validate :custom_email_validation
  validates :first_name, presence: true
  validates :last_name, presence: true

  # has_many :groups

  has_many :subject_teacher, dependent: :destroy
  has_many :subjects, through: :subject_teacher

  has_many :schedules

  def full_name
    "#{first_name} #{last_name}"
  end

  def custom_email_validation
    # Define your regex pattern here
    regex = /\A[^@\s]+@karazin\.ua\z/

    # Replace `email` with the attribute you want to validate
    return if email.match?(regex)

    errors.add(:email, 'must be an karazin.ua email address')
  end

  def self.ransackable_associations(_auth_object = nil)
    ["schedules", "subject_teacher", "subjects"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["city", "country", "created_at", "email", "encrypted_password", "first_name", "id", "last_name", "remember_created_at", "reset_password_sent_at", 
     "reset_password_token", "updated_at"]
  end
end
