# frozen_string_literal: true

# spec/factories/students.rb
FactoryBot.define do
  factory :student do
    first_name { "John" }
    last_name { "Doe" }
    email { "john.doe@example.com" }
    password { "password" }
    password_confirmation { "password" }
    association :group
  end
end
