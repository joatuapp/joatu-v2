class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]

  respond_to :html

  def index
    @offers = Offer.all
    respond_with(@offers)
  end

  def show
    respond_with(@offer)
  end

  def new
    @offer = OfferForm.new(Offer.new)
    respond_with(@offer)
  end

  def edit
    @offer = OfferForm.new(Offer.find(params[:id]))
  end

  def create
    @form = OfferForm.new(Offer.new(user_id: current_user.id))
    if @form.validate(params[:offer])
      @form.save
    end
    respond_with(@offer)
  end

  def update
    @form = OfferForm.new(Offer.find(params[:id]))
    if @form.validate(params[:offer])
      @form.save
    end
    respond_with(@offer)
  end

  def destroy
    @offer.destroy
    respond_with(@offer)
  end

  private
    def set_offer
      @offer = Offer.find(params[:id])
    end
end
