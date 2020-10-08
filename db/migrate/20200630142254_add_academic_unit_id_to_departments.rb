class AddAcademicUnitIdToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_reference :departments, :academic_unit, foreign_key: true
  end
end
