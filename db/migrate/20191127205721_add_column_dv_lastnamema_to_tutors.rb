class AddColumnDvLastnamemaToTutors < ActiveRecord::Migration[5.2]
  def change
  	add_column :tutors, :lastnamema, :string
  	add_column :tutors, :dv, :string
  end
end
