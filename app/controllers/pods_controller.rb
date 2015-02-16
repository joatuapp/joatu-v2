class PodsController < ApplicationController

  # Show's the user's home pod.
  def home
    @pod = current_user.home_pod
    authorize @pod, :show?
    render :show
  end
end

