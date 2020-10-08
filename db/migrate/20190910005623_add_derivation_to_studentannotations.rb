class AddDerivationToStudentannotations < ActiveRecord::Migration[5.2]
  def change
  	add_column :studentannotations, :derivation, :integer
  end
end
