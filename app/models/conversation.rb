class Conversation < Mailboxer::Conversation
  include Paginatable

  def self.user_inbox(user, pagination)
    user.mailbox.inbox.page(pagination.page).per(pagination.per)
  end

  def self.user_sentbox(user, pagination)
    user.mailbox.sentbox.page(pagination.page).per(pagination.per)
  end

  def self.user_trash(user, pagination)
    user.mailbox.trash.page(pagination.page).per(pagination.per)
  end

  def read_messages_for_user_and_box!(user_model, box)
    box_type = (box == 'trash') ? 'trash' : 'not_trash'
    receipts = user_model.mailbox.receipts_for(self).send(box_type)
    receipts.mark_as_read
    receipts.map(&:message)
  end

  def reply_to_all(user_model, body)
    last_receipt = user_model.mailbox.receipts_for(self.model).last
    user_model.reply_to_all(last_receipt, body)
  end

end
