class CreateAnnotations < ActiveRecord::Migration[5.2]
  def change
    create_table :annotations do |t|
      t.text :comment
      t.time :times
      t.references :user, foreign_key: true
      t.references :tutorial, foreign_key: true

      t.timestamps
    end
  end
end
