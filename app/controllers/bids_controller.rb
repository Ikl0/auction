class BidsController < ApplicationController
  def create
    @lot = Lot.find(params[:lot_id])
    @bid = @lot.bids.build(bid_params)
    @bid.user = current_user

    if @bid.save
      redirect_to lot_path(@lot), notice: 'Your bid has been placed.'
    else
      redirect_to lot_path(@lot), alert: @bids..errors.full_messages.to_sentence
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
