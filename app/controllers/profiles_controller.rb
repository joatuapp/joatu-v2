class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @profiles = Profile.query {|m| policy_scope m.all }
    respond_with(@profiles)
  end

  def show
    authorize @profile
    @offers = Offer.query {|m| @profile.model.user.offers.page(params[:page]).per(3) }
    respond_with(@profile)
  end

  def new
    @profile = ProfileForm.new(Profile.new)
    authorize @profile
    respond_with(@profile)
  end

  def edit
    authorize @profile
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
    @profile = Profile.query {|m| m.find(params[:id]) }
  end
end
