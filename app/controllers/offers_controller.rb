class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @offers = Offer.query {|m| policy_scope m.all }
    respond_with(@offers)
  end

  def show
    authorize @offer
    respond_with(@offer)
  end

  def new
    @form = OfferForm.new(Offer.new)
    authorize @form.model
    respond_with(@offer = @form)
  end

  def edit
    authorize @offer
    @offer = OfferForm.new(@offer)
  end

  def create
    @form = OfferForm.new(Offer.new(user: current_user))
    if @form.validate(params[:offer])
      authorize @form.model
      @form.save
    end
    respond_with(@offer = @form)
  end

  def update
    @form = OfferForm.new(@offer)
    if @form.validate(params[:offer])
      authorize @form.model
      @form.save
    end
    respond_with(@offer = @form)
  end

  def destroy
    authorize @offer
    @offer.destroy
    respond_with(@offer)
  end

  private
    def set_offer
      @offer = Offer.query {|m| m.find(params[:id]) }
    end
end
