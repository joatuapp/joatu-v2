class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @communities = Community.all
    respond_with(@communities)
  end

  def show
    respond_with(@community)
  end

  def new
    @community = Community.new
    respond_with(@community)
  end

  def edit
  end

  def create
    @community = Community.new(community_params)
    @community.save
    respond_with(@community)
  end

  def update
    @community.update(community_params)
    respond_with(@community)
  end

  def destroy
    @community.destroy
    respond_with(@community)
  end

  private
    def set_community
      @community = Community.find(params[:id])
    end

    def community_params
      params.require(:community).permit(:name)
    end
end
