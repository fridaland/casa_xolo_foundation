class AddFieldsToParents < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_column :parents, :family_name, :string
    add_column :parents, :primary_contact_name, :string
    add_column :parents, :primary_contact_email, :string
    add_column :parents, :parent_type, :integer
    add_column :parents, :status, :integer
    add_column :parents, :start_date, :date
    add_reference :parents, :pet, null: true, index: { algorithm: :concurrently }
  end
end
