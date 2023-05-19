class LotsController < ApplicationController
  before_action :set_lot, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /lots or /lots.json
  def index
    @lots = Lot.all
    @q = Lot.ransack(params[:q])
    @lots = @q.result(distinct: true)
  end

  # GET /lots/1 or /lots/1.json
  def show; end

  # GET /lots/new
  def new
    @lot = Lot.new
  end

  # GET /lots/1/edit
  def edit
    return if @lot.owned_by?(current_user)

    flash[:alert] = 'You are not authorized to edit this lot.'
    redirect_to lots_path
  end

  # POST /lots or /lots.json
  def create
    @lot = Lot.new(lot_params)

    respond_to do |format|
      if @lot.save
        format.html { redirect_to lot_url(@lot), notice: 'Lot was successfully created.' }
        format.json { render :show, status: :created, location: @lot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lots/1 or /lots/1.json
  def update
    if @lot.owned_by?(current_user)
      respond_to do |format|
        if @lot.update(lot_params)
          format.html { redirect_to lot_url(@lot), notice: 'Lot was successfully updated.' }
          format.json { render :show, status: :ok, location: @lot }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @lot.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = 'You are not authorized to update this lot.'
      redirect_to lots_path
      nil
    end
  end

  # DELETE /lots/1 or /lots/1.json
  def destroy
    if @lot.owned_by?(current_user)
      @lot.destroy

      respond_to do |format|
        format.html { redirect_to lots_url, notice: 'Lot was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:alert] = 'You are not authorized to update this lot.'
      redirect_to lots_path
      nil
    end
  end

  def tag
    @lots = Lot.find_by(tags: [params[:tag]])
  end

  private

  # Only allow a list of trusted parameters through.
  def lot_params
    params.require(:lot).permit(:name, :description, :category,
                                :initial_price, :auto_purchase_price, :end_time, :user_id, :tags, images: [])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_lot
    @lot = Lot.find(params[:id])
  end
end
