# frozen_string_literal: true

class CreateStudentTaskScores < ActiveRecord::Migration[7.0]
  def change
    create_table :student_task_scores do |t|
      t.references :student, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
