# app/workers/lot_check_worker.rb
class LotCheckWorker
  include Sidekiq::Worker

  def perform
    current_time = DateTime.current

    Lot.find_each do |lot|
      if lot.end_time <= current_time
        if lot.bids.present?
          highest_bid = lot.bids.order(amount: :desc).first
          lot.update(winner: highest_bid.user) if highest_bid
        else
          lot.update(end_time: current_time + 1.day)
        end
      end
    end
  end
end
