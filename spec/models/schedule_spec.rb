# frozen_string_literal: true

# spec/models/schedule_spec.rb

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:teacher) do
    Teacher.create!(first_name: "John", last_name: "Doe", email: "john.doe@karazin.ua", password: "password123", password_confirmation: "password123")
  end
  let(:subject_instance) { Subject.create!(name: "Mathematics", head_teacher: teacher, teachers: [teacher]) }
  let(:group) { Group.create!(name: "Group 1", subjects: [subject_instance]) }
  let(:schedule) { described_class.new(teacher:, subject: subject_instance, schedule_type: "lecture", groups: [group]) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(schedule).to be_valid
    end

    it 'is not valid without a schedule_type' do
      schedule.schedule_type = nil
      expect(schedule).to_not be_valid
    end

    it 'is not valid with an invalid schedule_type' do
      schedule.schedule_type = "invalid_type"
      expect(schedule).to_not be_valid
    end

    it 'is not valid if the teacher does not teach the subject' do
      another_teacher = Teacher.create!(first_name: "Jane", last_name: "Doe", email: "jane.doe@karazin.ua", password: "password123",
                                        password_confirmation: "password123")
      schedule.teacher = another_teacher
      expect(schedule).to_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:teacher) }
    it { should belong_to(:subject) }
    it { should have_many(:group_schedule).dependent(:destroy) }
    it { should have_many(:groups).through(:group_schedule) }
    it { should have_many(:student_attendances).dependent(:destroy) }
  end

  describe 'private methods' do
    describe '#teacher_must_teach_subject' do
      it 'adds an error if the teacher does not teach the subject' do
        another_teacher = Teacher.create!(first_name: "Jane", last_name: "Doe", email: "jane.doe@karazin.ua", password: "password123",
                                          password_confirmation: "password123")
        schedule.teacher = another_teacher
        schedule.valid?
        expect(schedule.errors[:teacher]).to include('must be authorized to teach this subject!')
      end
    end
  end
end
