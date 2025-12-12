class AddIntegerEnumColumnsToPets < ActiveRecord::Migration[8.1]
  def change
    add_column :pets, :size, :integer
    add_column :pets, :species, :integer
    add_column :pets, :status, :integer
    add_column :pets, :sex, :integer
  end
end
