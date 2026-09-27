class CreateBoardMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :board_members, &:timestamps
  end
end
