class PodsController < ApplicationController
  before_filter :authenticate_user!

  # Show's the user's home pod.
  def home
    @display_add_offers_and_requests = true

    @pod = current_user.pod
    @hub = @pod.hub
    @events = Event.available_for_pod(@pod, PaginationOptions.new(1, 3))
    authorize @pod, :show?
    render :show
  end
end

