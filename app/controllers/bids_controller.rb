class BidsController < ApplicationController
  def create
    @lot = Lot.find(params[:lot_id])
    @bid = @lot.bids.build(bid_params)
    @bid.user = current_user

    if @bid.save
      if @bid.amount >= @lot.auto_purchase_price
        @lot.update(winner: current_user)
        redirect_to won_lots_path, notice: "Congratulations, you have won #{@lot.name}!"
      else
        redirect_to lot_path(@lot), notice: 'Your bid has been placed.'
      end
    else
      redirect_to lot_path(@lot), alert: @bid.errors.full_messages.to_sentence
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
