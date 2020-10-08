class AddDepartmentIdToTutors < ActiveRecord::Migration[5.2]
  def change
    add_reference :tutors, :department, foreign_key: true
  end
end
