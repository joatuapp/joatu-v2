class CommunitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @communities = policy_scope Community.page(params[:page])
    respond_with(@communities)
  end

  def show
    authorize @community
    respond_with(@community)
  end

  def new
    @form = CommunityForm.new(Community.new)
    authorize @form.model
    respond_with(@community = @form)
  end

  def edit
    authorize @community
    @community = CommunityForm.new(@community)
  end

  def create
    @form = CommunityForm.new(Community.new)
    if @form.validate(params[:community])
      authorize @form.model
      @form.save
    end
    respond_with(@community = @form)
  end

  def update
    @form = CommunityForm.new(@community)
    if @form.validate(params[:community])
      authorize @form.model
      @form.save
    end
    respond_with(@community = @form)
  end

  def destroy
    authorize @community
    @community.destroy
    respond_with(@community)
  end

  private
    def set_community
      @community = Community.find params[:id]
    end
end
