# frozen_string_literal: true

# spec/models/task_spec.rb

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:subject_instance) { Subject.create!(name: "Mathematics", head_teacher:) }
  let(:teacher) do
    Teacher.create!(first_name: "John", last_name: "Doe", email: "john.doe@karazin.ua", password: "password123", password_confirmation: "password123")
  end
  let(:head_teacher) do
    Teacher.create!(first_name: "Jane", last_name: "Doe", email: "jane.doe@karazin.ua", password: "password123", password_confirmation: "password123")
  end
  let(:group) { Group.create!(name: "Group 1", subjects: [subject_instance]) }
  let(:task) { described_class.new(title: "Homework", description: "Solve problems", max_score: 50, subject: subject_instance, groups: [group]) }
  let(:student) do
    Student.create!(first_name: "Student", last_name: "One", email: "student.one@karazin.ua", password: "password123", password_confirmation: "password123")
  end

  before do
    group.students << student
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(task).to be_valid
    end

    it 'is not valid without a title' do
      task.title = nil
      expect(task).to_not be_valid
    end

    it 'is not valid without a description' do
      task.description = nil
      expect(task).to_not be_valid
    end

    it 'is not valid with a non-integer max_score' do
      task.max_score = 50.5
      expect(task).to_not be_valid
    end

    it 'is not valid with a max_score greater than 100' do
      task.max_score = 101
      expect(task).to_not be_valid
    end

    it 'is not valid with a max_score less than or equal to 0' do
      task.max_score = 0
      expect(task).to_not be_valid
    end

    it 'is not valid if the sum of max scores for the same group and subject exceeds 100' do
      described_class.create!(title: "Test", description: "Test description", max_score: 60, subject: subject_instance, groups: [group])
      task.max_score = 50
      expect(task).to_not be_valid
    end

    it 'is not valid if the groups are not associated with the subject' do
      unrelated_group = Group.create!(name: "Group 2")
      task.groups = [unrelated_group]
      expect(task).to_not be_valid
    end
  end

  context 'associations' do
    it { should have_and_belong_to_many(:groups) }
    it { should belong_to(:subject) }
    it { should have_many(:student_task_scores) }
    it { should have_many(:students).through(:student_task_scores) }
  end

  describe 'callbacks' do
    it 'creates student task scores after create' do
      expect { task.save }.to change { StudentTaskScore.count }.by(1)
    end
  end

  describe 'private methods' do
    describe '#create_student_task_scores' do
      it 'creates a StudentTaskScore for each student in each group' do
        task.save
        student_task_score = StudentTaskScore.find_by(task:, student:)
        expect(student_task_score).not_to be_nil
        expect(student_task_score.score).to eq(0)
      end
    end

    describe '#groups_must_belong_to_subject' do
      it 'adds an error if any group does not belong to the subject' do
        unrelated_group = Group.create!(name: "Group 2")
        task.groups << unrelated_group
        task.valid?
        expect(task.errors[:groups]).to include('must be associated with the subject')
      end
    end

    describe '#max_score_uniqueness_within_group_and_subject' do
      it 'adds an error if the sum of max scores for the same group and subject exceeds 100' do
        described_class.create!(title: "Test", description: "Test description", max_score: 60, subject: subject_instance, groups: [group])
        task.max_score = 50
        task.valid?
        expect(task.errors[:max_score]).to include('sum of max scores for the same group and subject cannot exceed 100')
      end
    end
  end
end
