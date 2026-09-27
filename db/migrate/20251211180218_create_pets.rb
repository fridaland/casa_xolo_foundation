class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets, &:timestamps
  end
end
