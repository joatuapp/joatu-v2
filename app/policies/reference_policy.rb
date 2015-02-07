class ReferencePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? &&
      record.from_user == user
  end

  def destroy?
    user.present? &&
      record.from_user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
