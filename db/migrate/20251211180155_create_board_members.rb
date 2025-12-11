class CreateBoardMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :board_members do |t|
      t.timestamps
    end
  end
end
