class AddColorToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :color, :string
  end
end
