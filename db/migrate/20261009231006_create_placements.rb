class CreatePlacements < ActiveRecord::Migration[8.1]
  def change
    create_table :placements do |t|
      t.references :parent, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.integer :placement_type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end
  end
end
