class OfferPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    user.present? && 
      record.user_id == user.id
  end

  def destroy?
    user.present? && 
      record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
