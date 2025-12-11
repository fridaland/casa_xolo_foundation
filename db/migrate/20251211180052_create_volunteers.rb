class CreateVolunteers < ActiveRecord::Migration[8.0]
  def change
    create_table :volunteers do |t|
      t.timestamps
    end
  end
end
