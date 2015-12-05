class RequestPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    user.present? && (
      user.is_admin? ||
      user.id == record.user.id
    )
  end

  def destroy?
    user.present? && (
      user.is_admin? ||
      user.id == record.user.id
    )
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
