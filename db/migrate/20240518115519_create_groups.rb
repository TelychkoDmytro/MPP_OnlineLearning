class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :teacher_id, null: false, foreign_key: true
      t.integer :head_student_id, foreign_key: { to_table: :students}

      t.timestamps
    end

    add_index :groups, :teacher_id
    add_index :groups, :head_student_id
  end
end
