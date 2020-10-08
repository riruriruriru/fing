class AddDateFromTutorials < ActiveRecord::Migration[5.2]
  def change
  	add_column :tutorials,:date,:date
  end
end
