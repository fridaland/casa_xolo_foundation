class AddSignupUrlToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :signup_url, :string
  end
end
