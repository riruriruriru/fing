class CreateStudentTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :student_tutorials do |t|
      t.boolean :present

      t.timestamps
    end
  end
end
