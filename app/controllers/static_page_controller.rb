class StaticPageController < ApplicationController
  skip_after_action :verify_authorized

  def home
  end

  def alpha_signup
  end
end
