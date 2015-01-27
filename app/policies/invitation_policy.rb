class InvitationPolicy < Struct.new(:user, :invitation)
  def send?
    user.is_admin?
  end
end
