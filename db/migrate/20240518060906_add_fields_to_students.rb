class AddFieldsToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :group_id, :integer
    add_column :students, :attended_classes, :text, array: true, default: [].to_yaml
    add_column :students, :subscribed_classes, :text, array: true, default: [].to_yaml
  end

  add_index :students, :group_id
end
