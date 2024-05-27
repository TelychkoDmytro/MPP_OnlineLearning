# frozen_string_literal: true

class CreateGroupSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :group_schedules do |t|
      t.references :group, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
