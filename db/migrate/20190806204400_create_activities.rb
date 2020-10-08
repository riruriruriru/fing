class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
