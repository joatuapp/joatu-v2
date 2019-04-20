class CommunityOffersController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def new
    event = Event.new
    event.build_community_offer_detail
    @form = PendingCommunityOfferForm.new(event)
    authorize @form.model
    respond_with @community_offer = @form
  end

  def create
    event = Event.new
    event.build_community_offer_detail
    @form = PendingCommunityOfferForm.new(event)
    @form.creator = current_user
    authorize @form.model
    if @form.validate(params[:community_offer])
      @form.sync
      @form.save do |data|
        @form.model.save!
        flash[:notice] = "Your community offer has been created, and is now pending approval!"
      end
      redirect_to home_pod_path
    else
      @community_offer = @form
      render :new
    end
  end
end

