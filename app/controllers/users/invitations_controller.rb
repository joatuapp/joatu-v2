class Users::InvitationsController < Devise::InvitationsController
  def edit
    resource.invitation_token = params[:invitation_token]
    @form = NewUserForm.new(resource)
    render :edit
  end

  private

  # Over-riding the accept_resource method so that we can make use of our
  # NewUserForm to validate incoming parameters, rather than depending on model
  # validations:
  def accept_resource
    resource = resource_class.find_by_invitation_token(update_resource_params[:invitation_token], false)
    @form = NewUserForm.new(resource)
    if @form.validate(update_resource_params)
      @form.sync
      @form.model.accept_invitation!
    end
    
    @form.model
  end
end
