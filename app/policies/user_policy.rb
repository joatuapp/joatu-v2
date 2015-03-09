class UserPolicy < ApplicationPolicy
  # This policy holds logic for which users can send messages to other
  # users. For now it just blocks users from sending messages to
  # themselves, but in future it could be expanded to support a blocking
  # system or other such features.
  def send_message_to?
    user != record
  end

  def leave_reference_for?
    user != record
  end

  def view_caps_balance?
    user == record || user.is_admin?
  end

  def update?
    user.id == record.id || super
  end

  def destroy?
    user.id == record.id || super
  end
end
