# frozen_string_literal: true

# spec/models/subject_spec.rb

require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:teacher) do
    Teacher.create!(first_name: "John", last_name: "Doe", email: "john.doe@karazin.ua", password: "password123", password_confirmation: "password123")
  end
  let(:head_teacher) do
    Teacher.create!(first_name: "Jane", last_name: "Doe", email: "jane.doe@karazin.ua", password: "password123", password_confirmation: "password123")
  end
  subject do
    described_class.new(
      name: "Mathematics",
      head_teacher:
    )
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a non-unique name' do
      described_class.create!(name: "Mathematics", head_teacher:)
      expect(subject).to_not be_valid
    end

    it 'is not valid if the head_teacher is not in the teachers list' do
      subject.teachers << teacher
      expect(subject).to_not be_valid
    end
  end

  context 'associations' do
    it { should have_many(:subject_teacher).dependent(:destroy) }
    it { should have_many(:teachers).through(:subject_teacher) }
    it { should belong_to(:head_teacher).class_name('Teacher') }
    it { should have_many(:group_subject).dependent(:destroy) }
    it { should have_many(:groups).through(:group_subject) }
    it { should have_many(:tasks).dependent(:destroy) }
    it { should have_many(:schedules) }
    it { should have_many(:student_subject_opt_outs) }
  end

  context 'custom validations' do
    it 'adds the head_teacher to teachers list if teachers list is empty' do
      subject.save
      expect(subject.teachers).to include(subject.head_teacher)
    end

    it 'does not add the head_teacher to teachers list if teachers list is not empty' do
      subject.teachers << teacher
      subject.save
      expect(subject.teachers).to_not include(subject.head_teacher)
    end
  end

  describe 'private methods' do
    describe '#head_teacher_in_teachers_list' do
      it 'adds an error if the head_teacher is not in the teachers list' do
        subject.teachers << teacher
        subject.valid?
        expect(subject.errors[:head_teacher]).to include("must be one of the subject's teachers")
      end
    end

    describe '#add_first_teacher_as_head_teacher' do
      it 'adds the head_teacher to the teachers list if it is empty' do
        subject.run_callbacks(:validation) { false } # To trigger before_validation callback
        expect(subject.teachers).to include(head_teacher)
      end
    end
  end
end
