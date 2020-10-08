class AddColumnlastnamemaToStudents < ActiveRecord::Migration[5.2]
  def change
  	add_column :students, :lastnamema, :string
  end
end
