class Message < DomainBase
  self.model_class = Mailboxer::Message

  attribute :sender
  attribute :recipients
  attribute :subject
  attribute :body
  attribute :conversation

  def persist!
    receipt = sender.send_message(recipients, body, subject)
    self.model = receipt.message
  end
end
