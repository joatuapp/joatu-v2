class Message < DomainModel
  self.model_class = Mailboxer::Message

  association :sender, :User
  collection :recipients, :User

  attribute :subject
  attribute :body
  attribute :conversation

  def persist!
    raise "Cannot persist a destroyed object!" if destroyed?

    recipient_models = recipients.map(&:model)
    receipt = sender.send_message(recipient_models, body, subject)
    self.model = receipt.message
    populate_from_model!
    self
  end
end
