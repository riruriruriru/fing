class AddStatusToTutorsStudents < ActiveRecord::Migration[5.2]
  def change
  	add_column :students, :status,:boolean
    add_column :tutors, :status,:boolean
  end
end
