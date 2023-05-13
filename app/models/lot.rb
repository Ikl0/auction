class Lot < ApplicationRecord
  belongs_to :user

  def self.count_all_lots
    count
  end
end
