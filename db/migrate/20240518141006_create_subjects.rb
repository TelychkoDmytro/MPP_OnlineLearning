class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :teacher_id, null: false, foreign_key: true

      t.timestamps
    end

    add_index :subjects, :teacher_id
  end
end
