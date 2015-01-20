class OfferPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    user.present? && 
      scope.where(id: record.id).exists?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.present?
        scope.owned_by(user)
      else
        scope.none
      end
    end
  end
end
