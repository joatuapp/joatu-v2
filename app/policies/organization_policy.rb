class OrganizationPolicy < ApplicationPolicy
  def show?
    # Private organizations are only visible to their members:
    if record.private?
      record.has_member?(user)
    else
      # Other organizations are visible only to logged in JoatUers.
      user.present?
    end
  end

  def create?
    user.is_admin?
  end

  def update?
    user.is_admin? || record.user_is_admin?(user)
  end

  def destroy?
    user.is_admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      raise UnauthorizedError if user.guest?

      if user.is_admin?
        scope
      else
        scope.public_or_member_of(user)
      end
    end
  end
end
