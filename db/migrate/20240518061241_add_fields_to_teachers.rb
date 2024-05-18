class AddFieldsToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
    add_column :teachers, :assigned_groups, :text, array: true, default: [].to_yaml
    add_column :teachers, :subject_id, :integer
  end

  add_index :teachers, :subject_id
end
