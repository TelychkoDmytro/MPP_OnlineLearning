# frozen_string_literal: true

class AddTypeToSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :schedule_type, :string
  end
end
