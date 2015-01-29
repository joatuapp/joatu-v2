class Conversation < Mailboxer::Conversation
  def self.user_inbox(user, pagination)
    user.mailbox.inbox.paginate(pagination)
  end

  def self.user_sentbox(user, pagination)
    user.mailbox.sentbox.paginate(pagination)
  end

  def self.user_trash(user, page)
    user.mailbox.trash.paginate(pagination)
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
