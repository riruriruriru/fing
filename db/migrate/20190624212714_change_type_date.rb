class ChangeTypeDate < ActiveRecord::Migration[5.2]
  def change
  	change_table :tutorials do |t|
  		t.change :date, :date
  end
end
	
	def down
    change_table :tutorials do |t|
      t.change :date, :datetime
    end
  end
end
