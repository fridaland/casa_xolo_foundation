class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions, &:timestamps
  end
end
