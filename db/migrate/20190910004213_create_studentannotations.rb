class CreateStudentannotations < ActiveRecord::Migration[5.2]
  def change
    create_table :studentannotations do |t|
      t.date :times
      t.text :comment
      t.references :statusannotation, foreign_key: true
      t.references :typeannotation, foreign_key: true
      t.references :user, foreign_key: true
      

      t.timestamps
    end
  end
end
