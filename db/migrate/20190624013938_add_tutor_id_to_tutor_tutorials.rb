class AddTutorIdToTutorTutorials < ActiveRecord::Migration[5.2]
  def change
    add_reference :tutor_tutorials, :tutor, foreign_key: {on_delete: :cascade}
  end
end
