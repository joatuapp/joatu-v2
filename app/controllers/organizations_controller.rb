class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @organizations = policy_scope(Organization).paginate(PaginationOptions.new(params[:page]))
    respond_with @organizations
  end

  def show
    authorize @organization
    # TODO: Add correct code here to look up and populate with the orgs offers
    # and requests:
    @offers = []
    @requests = []
    respond_with @organiztion
  end

  def new
    @organization = OrganizationForm.new(Organization.new)
    authorize @organization.model
    respond_with @organization
  end

  def edit
    authorize @organization
    @organization = OrganizationForm.new @organization
    respond_with @organization
  end

  def create
    @form = OrganizationForm.new(Organization.new)
    if @form.validate(params[:organization])
      authorize @form.model
      @form.save
    end
    respond_with(@organization = @form)
  end

  def update
    @form = OrganizationForm.new @organization
    if @form.validate(params[:organization])
      authorize @form.model
      @form.save
    end
    respond_with(@organization = @form)
  end

  def destroy
    authorize @organization
    @organization.destroy!
    respond_with @organization
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end
end

