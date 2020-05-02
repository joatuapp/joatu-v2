
module Users
  class RegistrationsController < Devise::RegistrationsController
    def new
      super
      @form = NewUserForm.new(resource)
      authorize @form.model
    end

    def create
      build_resource(sign_up_params)
      @form = NewUserForm.new(resource, tou_agreement: params[:user][:tou_agreement])

      # if @form.validate(sign_up_params)
      #   @form.save do |data|
      #     data = data.reject {|k,v| %w(tou_agreement).include? k }
      #     @form.model.update(data)
      #     @form.model.save!
      #   end
      # end
      super

      # byebug
    end
    
    # def build_resource(hash = nil)
    #   self.resource = registration_form = NewUserForm.new(resource_class.new(sign_up_params), tou_agreement: params[:user][:tou_agreement])
    #   unless hash.nil? || hash.length == 0
    #     self.resource.validate hash
    #   end
    # end
  end
end
