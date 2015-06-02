class OffersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_search_options, only: [:index, :search]
  skip_after_action :verify_authorized, only: [:index, :search]

  respond_to :html

  SearchQuery = Struct.new(:search, :order_by, :types_filter) do include ActiveModel::Model; end

  def index
    @search_form = OfferSearchForm.new(SearchQuery.new)
    @search_form.save do |search_data|
      @offers = policy_scope(Offer).search_results(search_data).paginate(PaginationOptions.new(params[:page]))
    end
    respond_with(@offers)
  end

  def show
    authorize @offer
    @offerer = @offer.user
    @offerer_requests = Request.owned_by(@offerer).paginate(PaginationOptions.new(params[:requests_page], 5))
    @offerer_references = Reference.to_user(@offerer, PaginationOptions.new(params[:references_page], 5))
    respond_with(@offer)
  end

  def new
    @form = OfferForm.new(Offer.new)
    set_form_options
    authorize @form.model
    respond_with(@offer = @form)
  end

  def edit
    authorize @offer
    set_form_options
    @offer = OfferForm.new(@offer)
  end

  def create
    @form = OfferForm.new(Offer.new(user: current_user))
    set_form_options
    authorize @form.model
    if @form.validate(params[:offer])
      @form.save
    end
    respond_with(@offer = @form)
  end

  def update
    @form = OfferForm.new(@offer)
    set_form_options
    authorize @form.model
    if @form.validate(params[:offer])
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
    params[:offer_search] ||= {}
    @search_form = OfferSearchForm.new(SearchQuery.new)

    if @search_form.validate(params[:offer_search])
      @search_form.save do |search_data|
        @offers = policy_scope(Offer).search_results(search_data).paginate(PaginationOptions.new(params[:page]))
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
        "Newest First" => :created_at_desc,
        "Oldest First" => :created_at_asc
      }
      @offer_type_options = Offer.detail_type_options
    end

    def set_form_options
      @offer_types = Offer.detail_type_options
      @user_pod = Pod.home_pod_for_user(current_user) 
      @user_orgs = Organization.where_user_is_member(current_user)
    end
end
