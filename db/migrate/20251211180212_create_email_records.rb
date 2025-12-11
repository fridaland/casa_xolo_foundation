class CreateEmailRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :email_records do |t|
      t.timestamps
    end
  end
end
