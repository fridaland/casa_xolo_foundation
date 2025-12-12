class RemoveEnumColumnsFromPets < ActiveRecord::Migration[8.1]
  def change
    safety_assured {
      remove_column :pets, :size, :string
      remove_column :pets, :species, :string
      remove_column :pets, :status, :string
      remove_column :pets, :sex, :string
    }
  end
end
