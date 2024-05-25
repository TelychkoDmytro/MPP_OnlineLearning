class RenameScoreToTask < ActiveRecord::Migration[7.0]
  def change
    rename_column :scores, :score, :max_score
    add_column :scores, :earned_score, :integer
    add_column :scores, :title, :string
    add_column :scores, :description, :string

    rename_table :scores, :tasks
  end
end
