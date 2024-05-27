# frozen_string_literal: true

class AddCityAndCountryToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :city, :string
    add_column :students, :country, :string
  end
end
