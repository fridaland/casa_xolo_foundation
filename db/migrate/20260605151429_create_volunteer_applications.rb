class CreateVolunteerApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_applications do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email, null: false
      t.text :message
      t.string :position
      t.string :status, default: "pending"
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
