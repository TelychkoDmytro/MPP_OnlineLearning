# frozen_string_literal: true

# spec/models/student_spec.rb
require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is valid with valid attributes' do
    group = FactoryBot.create(:group)
    student = FactoryBot.build(:student, group:)
    expect(student).to be_valid
  end

  it 'is not valid without a first name' do
    student = FactoryBot.build(:student, first_name: nil)
    expect(student).to_not be_valid
  end

  it 'is not valid without a last name' do
    student = FactoryBot.build(:student, last_name: nil)
    expect(student).to_not be_valid
  end

  it 'belongs to a group' do
    association = described_class.reflect_on_association(:group)
    expect(association.macro).to eq :belongs_to
  end

  it 'has many student_subject_opt_outs' do
    association = described_class.reflect_on_association(:student_subject_opt_outs)
    expect(association.macro).to eq :has_many
  end

  it 'has many student_attendances' do
    association = described_class.reflect_on_association(:student_attendances)
    expect(association.macro).to eq :has_many
  end

  it 'has many tasks through student_task_scores' do
    association = described_class.reflect_on_association(:tasks)
    expect(association.macro).to eq :has_many
    expect(association.options[:through]).to eq(:student_task_scores)
  end
end
