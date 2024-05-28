# frozen_string_literal: true

# spec/models/profile_spec.rb

require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:student) { Student.create!(name: "John Doe", email: "john@example.com") }

  describe "associations" do
    it { should belong_to(:student) }
  end

  describe "ransackable attributes" do
    it "allows searching by bio" do
      expect(Profile.ransackable_attributes).to include("bio")
    end

    it "allows searching by created_at" do
      expect(Profile.ransackable_attributes).to include("created_at")
    end

    it "allows searching by id" do
      expect(Profile.ransackable_attributes).to include("id")
    end

    it "allows searching by student_id" do
      expect(Profile.ransackable_attributes).to include("student_id")
    end

    it "allows searching by updated_at" do
      expect(Profile.ransackable_attributes).to include("updated_at")
    end
  end
end
