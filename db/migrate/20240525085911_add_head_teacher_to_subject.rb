class AddHeadTeacherToSubject < ActiveRecord::Migration[7.0]
  def change
    add_reference :subjects, :head_teacher, foreign_key: { to_table: :teachers }
  end
end
