class Users::OrganizationInvitationsController < Users::InvitationsController
  protected

  def invite_resource(&block)
    resource = resource_class.new(invite_params)
    membership = OrganizationMembership.new(
      user: resource,
      organization_id: params[:organization_id]
    )

    resource_class.transaction do
      resource.invite!(current_inviter, &block)
      membership.save!
    end

    resource
  end
end
