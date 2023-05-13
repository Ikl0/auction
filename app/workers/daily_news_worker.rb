class DailyNewsWorker
  include Sidekiq::Worker

  def perform
    recipients = User.all_users
    lots_amount = Lot.count_all_lots
    recipients.each do |recipient|
      DailyNewsMailer.daily_email(recipient, lots_amount).deliver_now
    end
  end
end
