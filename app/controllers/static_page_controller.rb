class StaticPageController < ApplicationController
  skip_after_action :verify_authorized

  def home
  end
end
