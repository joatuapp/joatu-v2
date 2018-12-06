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
        @form.model.email = vals[:email]
        if vals[:password].present? || vals[:password_confirmation].present?
          @form.model.password = vals[:password]
          @form.model.password_confirmation = vals[:password_confirmation]
        end
        @form.model.save!
        flash[:notice] = t('users.user_updated')
      end
    end

    respond_with(@user = @form, location: edit_user_path(@user))
  rescue => e
    render :edit
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
