class CreateParents < ActiveRecord::Migration[8.0]
  def change
    create_table :parents, &:timestamps
  end
end
