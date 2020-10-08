class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    
  end
end
