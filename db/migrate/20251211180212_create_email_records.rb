class CreateEmailRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :email_records, &:timestamps
  end
end
