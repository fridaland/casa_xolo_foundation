class AddCoreAttributesToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :name, :string, null: false
    add_column :pets, :species, :string, null: false
    add_column :pets, :breed, :string
    add_column :pets, :sex, :string, null: false
    add_column :pets, :color, :string, null: false
    add_column :pets, :description, :text, null: false
    add_column :pets, :size, :string
    add_column :pets, :temperament, :string, array: true, default: []
    add_column :pets, :age, :integer
    add_column :pets, :status, :string, default: :available
    add_column :pets, :spayed_neutered, :boolean, default: false
    add_column :pets, :vaccinated, :boolean, default: false
    add_column :pets, :microchipped, :boolean, default: false
    add_column :pets, :weight, :decimal, precision: 5, scale: 2
  end
end
