class StaticPageController < ApplicationController
  skip_after_action :verify_authorized
  before_action :redirect_if_signed_in

  caches_action :home, :alpha_signup

  def home
  end

  def alpha_signup
  end

  def tou
  end

  private
  def redirect_if_signed_in
    redirect_to dashboard_path if user_signed_in?
  end
end
