class ProfilePolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && 
      user.id == record.user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
