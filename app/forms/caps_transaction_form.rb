class CapsTransactionForm < ApplicationForm
  include MoneyRails::ActionViewExtension

  property :source, validates: {presence: true}
  property :destination, validates: {presence: true}

  # This is a virtual attribute that allows the destination to be set
  # as a user id:
  property :destination_user_id, virtual: true
  
  property :message_from_source, type: String
  property :caps, type: Money

  validate :caps_not_negative_or_zero, :source_can_spend, :cant_send_to_self

  def caps=(val)
    if val.is_a? Money
      super
    else
      super Money.new(val.to_f * Money::Currency.new("CAPS").subunit_to_unit)
    end
  end

  # Permit the destination to be set by ID:
  def destination_user_id=(val)
    self.destination = User.find val
  end

  def destination_user_id
    destination.try(:id)
  end

  private

  def caps_not_negative_or_zero
    if caps.cents < 0
      errors.add(:caps, "Transfer balance cannot be negative!")
    end

    if caps.cents == 0
      errors.add(:caps, "Transfer balance cannot be 0")
    end
  end

  def source_can_spend
    if source.present? && source.caps - caps < 0
      if source.is_a? User
        errors.add(:base, "#{source.name}'s current balance of #{humanized_money_with_symbol(source.caps)} #{source.caps.currency.iso_code} is not sufficient for this transfer. Requested transfer: #{humanized_money_with_symbol(caps)} #{source.caps.currency.iso_code}.")
      else
        errors.add(:source, "#{source.class.name.humanize} #{source.id}'s current balance of #{humanized_money_with_symbol(source.caps)} #{source.caps.currency.iso_code} is not sufficient for this transfer. Requested transfer: #{humanized_money_with_symbol(caps)} #{source.caps.currency.iso_code}.")
      end
    end
  end

  def cant_send_to_self
    if source.present? && destination.present? && source == destination
      errors.add(:base, "Cannot send CAPs to yourself!")
    end
  end
end
