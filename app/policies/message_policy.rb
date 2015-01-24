class MessagePolicy < ApplicationPolicy

  def show?
    record.conversation.present? && 
      record.conversation.is_participant(user)
  end

  def create?
    true
  end

  def update?
    record.conversation.present? && 
      record.conversation.is_participant(user)
  end

  def destroy?
    record.conversation.present? && 
      record.conversation.is_participant(user)
  end
end
