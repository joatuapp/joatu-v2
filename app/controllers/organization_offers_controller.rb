class OrganizationOffersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    authorize @offer
    @offerer = @offer.organization
    @offerer_requests = OrganizationRequest.owned_by(@offerer).paginate(PaginationOptions.new(params[:requests_page], 5))
    respond_with(@offer)
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @form = OrganizationOfferForm.new(OrganizationOffer.new(
      organization: @organization,
    ))
    @offer_types = OrganizationOffer.detail_type_options
    authorize @form.model
    respond_with(@offer = @form)
  end

  def edit
    authorize @offer
    @offer_types = OrganizationOffer.detail_type_options
    @offer = OrganizationOfferForm.new(@offer)
  end

  def create
    @form = OrganizationOfferForm.new(OrganizationOffer.new(
      user: current_user
    ))
    @offer_types = OrganizationOffer.detail_type_options
    authorize @form.model
    if @form.validate(params[:organization_offer])
      @form.save
    end
    respond_with(@form.model.organization, @offer = @form)
  end

  def update
    @form = OrganizationOfferForm.new(@offer)
    @offer_types = OrganizationOffer.detail_type_options
    authorize @form.model
    if @form.validate(params[:organization_offer])
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
    @offer = OrganizationOffer.find(params[:id])
  end
end
