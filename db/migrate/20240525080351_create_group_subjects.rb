class CreateGroupSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :group_subjects do |t|
      t.references :group, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
