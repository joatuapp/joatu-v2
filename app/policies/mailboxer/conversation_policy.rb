class Mailboxer::ConversationPolicy < ApplicationPolicy

  def show?
    record.present? && 
      record.is_participant?(user)
  end

  def update?
    record.present? && 
      record.is_participant?(user)
  end

  def destroy?
    record.present? && 
      record.is_participant?(user)
  end
end
