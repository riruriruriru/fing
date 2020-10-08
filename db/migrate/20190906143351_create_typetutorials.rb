class CreateTypetutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :typetutorials do |t|
      t.references :type, foreign_key: true
      t.references :tutorial, foreign_key: true

      t.timestamps
    end
  end
end
