class CreateTutorTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :tutor_tutorials do |t|
      t.boolean :present

      t.timestamps
    end
  end
end
