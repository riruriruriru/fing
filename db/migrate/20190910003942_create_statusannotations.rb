class CreateStatusannotations < ActiveRecord::Migration[5.2]
  def change
    create_table :statusannotations do |t|
      t.string :name

      t.timestamps
    end
  end
end
