# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :head_student, foreign_key: { to_table: :students }

      t.timestamps
    end
  end
end
