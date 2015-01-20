class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :verify_authorized, :except => :index, unless: -> { is_a? DeviseController }
  after_action :verify_policy_scoped, :only => :index, unless: -> { is_a? DeviseController }
end
