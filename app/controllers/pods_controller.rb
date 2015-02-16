class PodsController < ApplicationController
  before_filter :authenticate_user!

  # Show's the user's home pod.
  def home
    @pod = current_user.home_pod
    authorize @pod, :show?
    render :show
  end
end

