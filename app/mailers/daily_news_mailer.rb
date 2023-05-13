class DailyNewsMailer < ApplicationMailer
  def daily_email(user, lots_amount)
    @user = user
    @lots_amount = lots_amount
    mail to: user.email, subject: 'Daily Morning Info'
  end
end
