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

  private

  def custom_email_validation
    # Define your regex pattern here
    regex = /\A[^@\s]+@karazin\.ua\z/
    
    # Replace `email` with the attribute you want to validate
    unless email.match?(regex)
      errors.add(:email, "must be an karazin.ua email address")
    end
  end
end
