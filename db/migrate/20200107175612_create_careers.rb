class CreateCareers < ActiveRecord::Migration[5.2]
  def change
    create_table :careers do |t|
      t.integer :code
      t.string :name
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
