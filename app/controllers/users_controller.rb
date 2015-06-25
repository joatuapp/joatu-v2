class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user

  respond_to :html

  def edit
    authorize @user
    @user = UserForm.new(@user)
  end

  def update
    @form = UserForm.new(@user)
    if @form.validate(params[:user])
      authorize @form.model
      @form.save do |vals|
        unless vals[:password].present? || vals[:password_confirmation].present?
          vals.delete :password
          vals.delete :password_confirmation
        end
        @form.model.update! vals
        flash[:notice] = t('users.user_updated')
      end
    end

    respond_with(@user = @form, location: edit_user_path(@user))
  end

  def destroy
    authorize @user
    @user.destroy!
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
