class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_search_options, only: [:index, :search]
  skip_after_action :verify_authorized, only: [:index, :search]

  respond_to :html

  SearchQuery = Struct.new(:search, :order_by, :types_filter) do include ActiveModel::Model; end

  def index
    @search_form = OfferSearchForm.new(SearchQuery.new)
    @search_form.save do |search_data|
      @offers = Offer.search_results(search_data, current_user, PaginationOptions.new(params[:page]))
    end
    respond_with(@offers)
  end

  def show
    authorize @offer
    @offerer = @offer.user
    @offerer_requests = Request.owned_by(@offerer, PaginationOptions.new(params[:requests_page], 5))
    @offerer_references = Reference.to_user(@offerer, PaginationOptions.new(params[:references_page], 5))
    respond_with(@offer)
  end

  def new
    @form = OfferForm.new(Offer.new)
    @offer_types = Offer.type_options
    authorize @form.model
    respond_with(@offer = @form)
  end

  def edit
    authorize @offer
    @offer_types = Offer.type_options
    @offer = OfferForm.new(@offer)
  end

  def create
    @form = OfferForm.new(Offer.new(user: current_user))
    @offer_types = Offer.type_options
    authorize @form.model
    if @form.validate(params[:offer])
      if @form.visibility == :pod && current_user.pod_id
        @form.model.pod = current_user.pod
      else
        @form.model.pod = nil
      end
      @form.save
    end
    respond_with(@offer = @form)
  end

  def update
    @form = OfferForm.new(@offer)
    @offer_types = Offer.type_options
    authorize @form.model
    if @form.validate(params[:offer])
      if @form.visibility == :pod
        @form.model.pod = current_user.pod
      else
        @form.model.pod = nil
      end
      @form.save
    end
    respond_with(@offer = @form)
  end

  def destroy
    authorize @offer
    @offer.destroy
    respond_with(@offer, location: offers_path)
  end

  def search
    params[:offer_search] ||= {}
    @search_form = OfferSearchForm.new(SearchQuery.new)

    if @search_form.validate(params[:offer_search])
      @search_form.save do |search_data|
        @offers = Offer.search_results(
          search_data,
          current_user,
          PaginationOptions.new(params[:page])
        )
        render :index
      end
    else
      redirect_to offers_path
    end
  end

  private
    def set_offer
      @offer = Offer.find(params[:id])
    end

    def set_search_options
      @order_options = {
        I18n.t('offers_and_requests.forms.list.values.order_by.newest_first') => :created_at_desc,
        I18n.t('offers_and_requests.forms.list.values.order_by.oldest_first') => :created_at_asc
      }
      @offer_type_options = Offer.type_options
    end
end
