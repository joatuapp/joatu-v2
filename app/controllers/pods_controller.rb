class PodsController < ApplicationController
  before_filter :authenticate_user!

  # Show's the user's home pod.
  def home
    @pod = Pod.home_pod_for_user(current_user)
    authorize @pod, :show?
    render :show
  end
end

