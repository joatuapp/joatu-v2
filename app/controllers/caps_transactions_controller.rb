class CapsTransactionsController < ApplicationController
  include MoneyRails::ActionViewExtension

  before_action :authenticate_user!

  # NOTE: Currently assumes that it will be called from a form embedded within
  # the profile page, so it redirects there on success / failure.
  def create
    @form = CapsTransactionForm.new(CapsTransaction.new(source: current_user))
    authorize @form.model
    if @form.validate(params[:caps_transaction])
      TransferCaps.call(@form, current_user)
      flash[:notice] = t('caps.caps_sent_successfully_message', caps: "#{humanized_money @form.caps} #{@form.caps.currency.iso_code}", recipient_name: @form.destination.name)
    else
      flash[:alert] = t('caps.caps_failed_to_send', error_message: @form.errors.full_messages.first)
    end
    redirect_to profile_path @form.destination.profile
  end
end
