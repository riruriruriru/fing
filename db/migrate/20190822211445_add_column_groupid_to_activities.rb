class AddColumnGroupidToActivities < ActiveRecord::Migration[5.2]
  def change
  	add_column :activities, :groupId, :string
  end
end
