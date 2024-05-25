class AddCityAndCountryToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :city, :string
    add_column :teachers, :country, :string
  end
end
