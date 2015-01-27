class InvitationPolicy < Struct.new(:user, :invitation)
  def send?
    user.present? && user.is_admin?
  end
end
