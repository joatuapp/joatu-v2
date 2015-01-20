class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @offers = policy_scope Offer.all
    respond_with(@offers)
  end

  def show
    authorize @offer
    respond_with(@offer)
  end

  def new
    @form = OfferForm.new(Offer.new)
    authorize @form
    respond_with(@form)
  end

  def edit
    authorize @offer
    @form = OfferForm.new(@offer)
    respond_with(@form)
  end

  def create
    @form = OfferForm.new(Offer.new(user_id: current_user.id))
    authorize @form
    if @form.validate(params[:offer])
      @form.save
    end
    respond_with(@form)
  end

  def update
    authorize @offer
    @form = OfferForm.new(@offer)
    if @form.validate(params[:offer])
      @form.save
    end
    respond_with(@form)
  end

  def destroy
    authorize @offer
    @offer.destroy
    respond_with(@offer)
  end

  private
    def set_offer
      @offer = Offer.find(params[:id])
    end
end
