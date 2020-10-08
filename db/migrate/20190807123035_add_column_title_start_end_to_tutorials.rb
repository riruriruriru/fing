class AddColumnTitleStartEndToTutorials < ActiveRecord::Migration[5.2]
    def change
    add_column :tutorials, :title, :string
    add_column :tutorials, :start, :date
    add_column :tutorials, :end, :date
  end

end
