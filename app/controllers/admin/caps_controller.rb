class Admin::CapsController < Admin::ApplicationController
  include MoneyRails::ActionViewExtension

  respond_to :html

  # Display the form an admin can use to generate caps:
  def new
    @users = User.all
    @organizations = Organization.all
    @form = CapsTransactionForm.new(CapsTransaction.new(source: CapsGenerator.instance))
    authorize @form.model
    respond_with(@caps_transaction = @form)
  end

  # Create new CAPs by creating a transfer from the CapsGenerator
  def create
    @form = CapsTransactionForm.new(CapsTransaction.new(source: CapsGenerator.instance))
    authorize @form.model
    if @form.validate(params[:caps_transaction])
      TransferCaps.call(@form, current_user)
      flash[:notice] = t('admin.caps.caps_awarded_successfully_message', caps: "#{humanized_money @form.caps} #{@form.caps.currency.iso_code}", recipient_name: @form.destination.name)
      redirect_to admin_generate_caps_path
    else
      @caps_transaction = @form
      render :new
    end
  end
end
