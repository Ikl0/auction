class AddUserIdToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :user_id, :integer
    add_index :lots, :user_id
  end
end
