class Conversation < DomainModel
  self.model_class = Mailboxer::Conversation

  attribute :subject
  attribute :created_at, nil, writer: :private
  attribute :updated_at, nil, writer: :private

  association :last_sender, :User, writer: :private
  association :last_message, :Message, writer: :private
  collection :recipients, :User, writer: :private


  delegate :is_participant?, :is_unread?, to: :model

  def self.query
    wrap_query_results(yield Queries.new(model_class))
  end

  def read_messages_for_user_and_box!(user_model, box)
    box_type = (box == 'trash') ? 'trash' : 'not_trash'
    receipts = user_model.mailbox.receipts_for(self.model).send(box_type)
    receipts.mark_as_read
    receipts.map(&:message).map {|m| Message.new(m)}
  end

  def reply_to_all(user_model, body)
    last_receipt = user_model.mailbox.receipts_for(self.model).last
    user_model.reply_to_all(last_receipt, body)
  end

  def persist!
    raise "Not implemented"
  end

  # Takes one parameter, the messageable that is destrying the conversation
  # (it show as trashed only for them)
  def destroy!(destroyer)
    @model.move_to_trash(destroyer)
  end

  class Queries < SimpleDelegator
    def initialize(model_class)
      @model = model_class
      super @model
    end

    def user_conversations(user, box)
      user.mailbox.send(box)
    end
  end
end
