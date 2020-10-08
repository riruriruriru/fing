class CreateTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :tutorials do |t|
      t.integer :subject
      t.text :contents

      t.timestamps
    end
  end
end
