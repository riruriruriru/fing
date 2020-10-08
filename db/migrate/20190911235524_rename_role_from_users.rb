class RenameRoleFromUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :role, :rolesdevise
  end
end
