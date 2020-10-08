class CreateTypeannotations < ActiveRecord::Migration[5.2]
  def change
    create_table :typeannotations do |t|
      t.string :name

      t.timestamps
    end
  end
end
