class AddTutorialIdToStudentTutorials < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_tutorials, :tutorial, foreign_key: {on_delete: :cascade}
  end
end
