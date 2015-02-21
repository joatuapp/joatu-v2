class PodsController < ApplicationController
  before_filter :authenticate_user!

  # Show's the user's home pod.
  def home
    @pod = Pod.home_pod_for_user(current_user)
    @hub = @pod.hub
    @events = Event.available_for_pod(@pod, PaginationOptions.new(1, 3))
    authorize @pod, :show?
    render :show
  end
end

