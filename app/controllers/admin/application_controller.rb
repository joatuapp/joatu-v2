class Admin::ApplicationController < ApplicationController
  # Authenticate user for ALL admin controllers:
  before_action :authenticate_user!
end
