class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people, &:timestamps
  end
end
