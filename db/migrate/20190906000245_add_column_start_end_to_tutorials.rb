class AddColumnStartEndToTutorials < ActiveRecord::Migration[5.2]
  def change
    add_column :tutorials, :timestart, :time
    add_column :tutorials, :timeend, :time
  end
end
