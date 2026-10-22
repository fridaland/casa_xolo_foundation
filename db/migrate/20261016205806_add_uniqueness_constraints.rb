class AddUniquenessConstraints < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :parents, :primary_contact_email,
      unique: true,
      algorithm: :concurrently

    add_index :placements, %i[parent_id pet_id placement_type],
      unique: true,
      algorithm: :concurrently
  end
end
