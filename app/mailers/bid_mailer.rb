class BidMailer < ApplicationMailer
  def new_bid_email(user, lot, leading_bid)
    @user = user
    @lot = lot
    @leading_bid = leading_bid
    mail to: user.email, subject: "New Bid for #{@lot.name}"
  end
end
