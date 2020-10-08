class CreateTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :tutors do |t|
      t.integer :rut
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :phone
      t.integer :level
      t.integer :careercode

      t.timestamps
    end
  end
end
