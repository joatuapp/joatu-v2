class StaticPageController < ApplicationController
  skip_after_action :verify_authorized

  def home
    redirect_to dashboard_path if user_signed_in?
  end

  def alpha_signup
  end
end
