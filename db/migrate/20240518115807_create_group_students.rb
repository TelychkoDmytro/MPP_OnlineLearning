class CreateGroupStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :group_students do |t|
      t.integer :group_id, null: false, foreign_key: true
      t.integer :student_id, null: false, foreign_key: true

      t.timestamps
    end

    add_index :group_students, :group_id
    add_index :group_students, :student_id
    add_index :group_students, [:group_id, :student_id], unique: true
  end
end
