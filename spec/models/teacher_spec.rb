# frozen_string_literal: true

# spec/models/teacher_spec.rb

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  subject do
    described_class.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@karazin.ua",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a valid email' do
      subject.email = "john.doe@gmail.com"
      expect(subject).to_not be_valid
    end

    it 'is valid with a karazin.ua email' do
      subject.email = "john.doe@karazin.ua"
      expect(subject).to be_valid
    end
  end

  context 'associations' do
    it { should have_many(:subject_teacher).dependent(:destroy) }
    it { should have_many(:subjects).through(:subject_teacher) }
    it { should have_many(:schedules) }
  end

  context 'methods' do
    describe '#full_name' do
      it 'returns the full name of the teacher' do
        expect(subject.full_name).to eq('John Doe')
      end
    end
  end

  context 'custom validations' do
    it 'validates email format' do
      invalid_teacher = described_class.new(email: 'john.doe@gmail.com')
      invalid_teacher.valid?
      expect(invalid_teacher.errors[:email]).to include('must be an karazin.ua email address')
    end
  end
end
