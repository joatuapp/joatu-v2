class OrganizationOfferPolicy < OfferPolicy
  def show?
    # Private organizations are only visible to their members:
    if record.organization.private?
      record.has_member?(user)
    else
      # Other organizations are visible only to logged in JoatUers.
      user.present?
    end
  end

  def create?
    Pundit.policy(user, record.created_by_organization).create_offer?
  end

  def update?
    user.is_admin? || record.created_by_organization.user_is_admin?(user)
  end

  def destroy?
    user.is_admin? || record.created_by_organization.user_is_admin?(user)
  end
end
