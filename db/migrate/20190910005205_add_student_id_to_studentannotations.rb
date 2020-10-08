class AddStudentIdToStudentannotations < ActiveRecord::Migration[5.2]
  def change
    add_reference :studentannotations, :student, foreign_key: {on_delete: :cascade}
  end
end
