class AddWinnerToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :winner_id, :integer
  end
end
