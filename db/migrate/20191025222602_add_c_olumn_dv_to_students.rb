class AddCOlumnDvToStudents < ActiveRecord::Migration[5.2]
  def change
  	 add_column :students, :dv, :integer
  end
end
