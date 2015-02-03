class UserPolicy < ApplicationPolicy
  def update?
    user.id == record.id || super
  end

  def destroy?
    user.id == record.id || super
  end
end
