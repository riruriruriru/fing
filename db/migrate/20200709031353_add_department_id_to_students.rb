class AddDepartmentIdToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :department, foreign_key: true
  end
end
