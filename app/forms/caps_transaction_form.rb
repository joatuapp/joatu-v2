class CapsTransactionForm < ApplicationForm
  include MoneyRails::ActionViewExtension

  property :source, validates: {presence: true}
  property :destination, validates: {presence: true}
  property :message_from_source, type: String
  property :caps, type: Money

  validate :caps_not_negative, :source_can_spend

  def caps=(val)
    if val.is_a? Money
      super
    else
      super Money.new(val * Money::Currency.new("CAPS").subunit_to_unit)
    end
  end

  private

  def caps_not_negative
    if caps.cents < 0
      errors.add(:caps, "Transfer balance cannot be negative!")
    end
  end

  def source_can_spend
    if source.caps - caps < 0
      errors.add(:source, "#{source.class.name.humanize} #{source.id}'s current balance of #{humanized_money_with_symbol(source.caps)} #{source.caps.currency.iso_code} is not sufficient for this transfer. Requested transfer: #{humanized_money_with_symbol(caps)} #{source.caps.currency.iso_code}.")
    end
  end
end
