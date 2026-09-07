class AddFosterableToPets < ActiveRecord::Migration[8.1]
  def change
    add_column :pets, :fosterable, :boolean, default: false, null: false
  end
end
