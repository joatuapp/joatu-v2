
module Users
  class RegistrationsController < Devise::RegistrationsController
    def new
      @form = NewUserForm.new(User.new)
      authorize @form.model
      super
    end
  end
end
