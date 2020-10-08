class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.integer :rut
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :careercode
      t.integer :level

      t.timestamps
    end
  end
end
