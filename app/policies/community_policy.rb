class CommunityPolicy < ApplicationPolicy
  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
