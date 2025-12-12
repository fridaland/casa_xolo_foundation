class AddNameToPeople < ActiveRecord::Migration[8.1]
  def change
    add_column :people, :name, :string
  end
end
