class DailyNewsWorker
  include Sidekiq::Worker

  def perform
    recipients = User.all
    recipients.each do |recipient|
      DailyNewsMailer.daily_email(recipient).deliver_now
    end
  end
end
