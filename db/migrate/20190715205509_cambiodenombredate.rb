class Cambiodenombredate < ActiveRecord::Migration[5.2]
  def change
  	rename_column :tutorials, :date, :dates
  end
end
