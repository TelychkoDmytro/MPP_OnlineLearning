class CreateStudentAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :student_attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
