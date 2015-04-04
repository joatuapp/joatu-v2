class Admin::CapsController < Admin::ApplicationController
  # Display the form an admin can use to generate caps:
  def new
    @users = User.all
    @organizations = Organization.all
    @form = CapsTransactionForm.new(CapsTransaction.new(source: CapsGenerator.instance))
    respond_with(@caps_transaction = @form)
  end

  # Create new CAPs by creating a transfer from the CapsGenerator
  def create
    @form = CapsTransactionForm.new(CapsTransaction.new(source: CapsGenerator.instance))
    authorize @form.model
    if @form.validate(params[:caps_transaction])
      TransferCaps.call(@form, current_user)
    end
    respond_with(@caps_transaction = @form)
  end
end