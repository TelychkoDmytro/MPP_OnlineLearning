class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.text :bio
      t.integer :age
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
