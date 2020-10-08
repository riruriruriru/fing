class RemoveLastnameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :lastname, :string
    remove_column :users, :firstname, :string
  end
end
