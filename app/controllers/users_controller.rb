class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user

  def edit
    authorize @user
    @form = UserForm.new(@user)
  end

  def update
    @form = UserForm.new(@user)
    if @form.validate(params[:user])
      authorize @form.model
      @form.save
    end

    respond_with(@user = @form)
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
