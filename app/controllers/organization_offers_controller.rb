class OrganizationOffersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_form_options, only: [:new, :create]

  respond_to :html

  def new
    @organization = Organization.find(params[:organization_id])
    @form = OrganizationOfferForm.new(OrganizationOffer.new(
      created_by_organization: @organization,
    ))
    authorize @form.model
    respond_with(@offer = @form)
  end

  def create
    @form = OrganizationOfferForm.new(OrganizationOffer.new(
      created_by_user: current_user
    ))
    authorize @form.model
    if @form.validate(params[:organization_offer])
      @form.save
    end
    respond_with(@form.model.created_by_organization, @offer = @form)
  end

  private
  
  def set_form_options
    @offer_types = OrganizationOffer.detail_type_options
  end
end
