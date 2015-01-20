class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @profiles = policy_scope Profile.all
    respond_with(@profiles)
  end

  def show
    authorize @profile
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
    @profile = ProfileForm.new(Profile.new(user_id: current_user.id))
    if @profile.validate(params[:profile])
      authorize @profile
      @profile.save
    end
    respond_with(@profile)
  end

  def update
    @profile = ProfileForm.new(@profile)
    if @profile.validate(params[:profile])
      authorize @profile
      @profile.save
    end
    respond_with(@profile)
  end

  def destroy
    authorize @profile
    @profile.destroy
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end
end
