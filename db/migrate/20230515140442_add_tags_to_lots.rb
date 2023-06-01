class AddTagsToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :tags, :jsonb, null: false, default: []
  end
end
