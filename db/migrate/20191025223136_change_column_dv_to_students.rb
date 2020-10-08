class ChangeColumnDvToStudents < ActiveRecord::Migration[5.2]
  def change
  	 change_column :students, :dv, :string
  end
end
