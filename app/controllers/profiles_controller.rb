class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @profiles = Profile.available_to(current_user, PaginationOptions.new(params[:page]))
    respond_with(@profiles)
  end

  def show
    authorize @profile
    @offers = Offer.owned_by(@profile.user, PaginationOptions.new(params[:offers_page], 5))
    @requests = Request.owned_by(@profile.user, PaginationOptions.new(params[:requests_page], 5))
    @references = Reference.to_user(@profile.user, PaginationOptions.new(params[:references_page], 5))
    @tip_transaction = CapsTransactionForm.new(CapsTransaction.new(
      source: current_user,
      destination: @profile.user,
    ))
    respond_with(@profile)
  end

  def new
    @profile = ProfileForm.new(Profile.new)
    authorize @profile.model
    redirect_to profile_path(current_user.profile) and return if current_user.profile.persisted?
    respond_with(@profile)
  end

  def edit
    authorize @profile
    ProfileForm.new(@profile)
  end

  def create
    @form = ProfileForm.new(Profile.new(user: current_user))
    if @form.validate(params[:profile])
      authorize @form.model
      @form.save
    end
    respond_with(@profile = @form)
  end

  def update
    @form = ProfileForm.new(@profile)
    if @form.validate(params[:profile])
      authorize @form.model
      @form.save
    end
    respond_with(@profile = @form)
  end

  def destroy
    authorize @profile
    @profile.destroy!
    respond_with(@profile)
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
