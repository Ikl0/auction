class DailyNewsMailer < ApplicationMailer
  def daily_email(user)
    @user = user
    mail to: user.email, subject: 'Daily Morning Info'
  end
end
