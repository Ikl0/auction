class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :name
      t.string :description
      t.string :category
      t.decimal :initial_price
      t.decimal :auto_purchase_price
      t.datetime :end_time

      t.timestamps
    end
  end
end
