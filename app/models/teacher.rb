class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom validation using regex
  validate :custom_email_validation

  private

  def custom_email_validation
    # Define your regex pattern here
    regex = /\A[^@\s]+@karazin\.ua\z/
    
    # Replace `email` with the attribute you want to validate
    unless email.match?(regex)
      errors.add(:email, "must be an example.com email address")
    end
  end
end
