class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: ->(bid) { bid.lot.initial_price } }
end
