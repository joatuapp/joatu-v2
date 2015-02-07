class ReferencesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_reference, only: [:edit, :update, :destroy] 

  respond_to :html

  def new
    if params[:to_user_id]
      to_user = User.find params[:to_user_id]
      @to_user_offers = to_user.offers
      model = Reference.new(to_user: to_user)
    else
      model = Reference.new
    end
    @form = ReferenceForm.new(model)

    authorize @form.model
    respond_with(@reference = @form)
  end

  def edit
    authorize @reference
    @reference = ReferenceForm.new(@reference)
  end

  def create
    @form = ReferenceForm.new(Reference.new(from_user: current_user))
    authorize @form.model
    if @form.validate(params[:reference])
      @form.save
    end
    respond_with(@reference = @form, location: profile_path(@reference.to_user.profile))
  end

  def update
    @form = ReferenceForm.new(@reference)
    authorize @form.model
    if @form.validate(params[:reference])
      @form.save
    end
    respond_with(@reference = @form, location: profile_path(@reference.model.to_user.profile))
  end

  def destroy
    authorize @reference
    @reference.destroy
    respond_with(@reference)
  end

  private

  def set_reference
    @reference = Reference.find(params[:id])
  end
end

