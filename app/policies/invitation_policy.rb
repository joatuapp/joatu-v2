class InvitationPolicy < Struct.new(:user, :invitation)

  NullObject = Naught.build
  include NullObject::Conversions

  def send?
    Actual(user).present? && (user.is_admin? || OrganizationMembership.user_is_org_admin?(user))
  end
end
