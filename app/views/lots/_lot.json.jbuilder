json.extract! lot, :id, :name, :description, :category, :initial_price, :auto_purchase_price, :end_time, :created_at,
              :updated_at
json.url lot_url(lot, format: :json)
