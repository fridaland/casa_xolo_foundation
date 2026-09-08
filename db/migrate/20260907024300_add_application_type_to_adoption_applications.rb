class AddApplicationTypeToAdoptionApplications < ActiveRecord::Migration[8.1]
  def change
    add_column :adoption_applications, :application_type, :string, default: "adoption", null: false
  end
end
