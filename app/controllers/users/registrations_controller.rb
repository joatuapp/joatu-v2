
module Users
  class RegistrationsController < Devise::RegistrationsController
    def new
      @form = NewUserForm.new(User.new)
      authorize @form.model
      super
    end

    def create
      build_resource(sign_up_params)
      @form = NewUserForm.new(resource)

      # if @form.validate(update_params)
      #   @form.save do |data|
      #     data = data.reject {|k,v| %w(tou_agreement).include? k }
      #     @form.model.update(data)
      #     @form.model.accept_invitation!
      #   end
      # end
      super

    end
  end
end
