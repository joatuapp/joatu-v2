class Message < DomainModel
  self.model_class = Mailboxer::Message

  attribute :sender, DomainModel.attr_type(:User) 
  attribute :recipients, Array[DomainModel.attr_type(:User)]
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
