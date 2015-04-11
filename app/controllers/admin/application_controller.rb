class Admin::ApplicationController < ApplicationController
  # Authenticate user for ALL admin controllers:
  before_filter :authenticate_user!
end
