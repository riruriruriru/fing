class AddColumnEntryToStudents < ActiveRecord::Migration[5.2]
  def change
  	add_column :students, :entry, :integer
  end
end
