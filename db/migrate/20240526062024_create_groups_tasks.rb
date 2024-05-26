class CreateGroupsTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_tasks do |t|
      t.references :group, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
