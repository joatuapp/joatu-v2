class Message < DomainModel
  self.model_class = Mailboxer::Message

  association :conversation, :Conversation
  association :sender, :User
  collection :recipients, :User

  attribute :subject
  attribute :body

  attribute :created_at, nil, writer: :private
  attribute :updated_at, nil, writer: :private

  delegate :is_unread?, to: :model

  def persist!
    raise "Cannot persist a destroyed object!" if destroyed?

    recipient_models = recipients.map(&:model)
    receipt = sender.model.send_message(recipient_models, body, subject)
    self.model = receipt.message
    populate_from_model!
    self
  end
end
