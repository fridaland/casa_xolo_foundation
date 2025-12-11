class CreateParents < ActiveRecord::Migration[8.0]
  def change
    create_table :parents do |t|
      t.timestamps
    end
  end
end
