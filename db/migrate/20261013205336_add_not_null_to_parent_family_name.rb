class AddNotNullToParentFamilyName < ActiveRecord::Migration[8.1]
  def change
    safety_assured { change_column_null :parents, :family_name, false, "" }
  end
end
