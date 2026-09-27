class CreateDonors < ActiveRecord::Migration[8.0]
  def change
    create_table :donors, &:timestamps
  end
end
