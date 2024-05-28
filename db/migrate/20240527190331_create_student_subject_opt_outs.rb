# frozen_string_literal: true

class CreateStudentSubjectOptOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :student_subject_opt_outs do |t|
      t.references :student, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
