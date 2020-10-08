class AddStudentIdToStudentTutorials < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_tutorials, :student, foreign_key: {on_delete: :cascade}
  end
end
