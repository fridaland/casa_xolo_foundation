class RemovePlacementFieldsFromParents < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      remove_column :parents, :parent_type, :integer
      remove_column :parents, :status, :integer
      remove_column :parents, :start_date, :date
      remove_column :parents, :pet_id, :integer
    end
  end
end
