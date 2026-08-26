class CreateAdoptionApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :adoption_applications do |t|
      t.references :pet, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :housing_type, null: false
      t.string :owns_or_rents, null: false
      t.string :has_yard, null: false
      t.string :has_other_pets, null: false
      t.string :has_children, null: false
      t.text :pet_experience, null: false
      t.text :adoption_reason, null: false
      t.text :references
      t.string :status, default: "pending"
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
