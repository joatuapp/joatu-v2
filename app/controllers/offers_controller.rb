class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:index, :search]
  after_action :verify_policy_scoped, only: [:index, :search]

  respond_to :html

  SearchQuery = Struct.new(:search)

  def index
    @offers = Offer.query {|m| policy_scope m.all }
    @search_form = OfferSearchForm.new(SearchQuery.new)
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

  def search
    @search_form = OfferSearchForm.new(SearchQuery.new)
    if @search_form.validate(params[:offer_search])
      @search_form.save do |search_data|
        @offers = Offer.query {|m| policy_scope m.where("title LIKE ?", "#{search_data[:search]}%") }
        render :index
      end
    end
  end

  private
    def set_offer
      @offer = Offer.query {|m| m.find(params[:id]) }
    end
end
