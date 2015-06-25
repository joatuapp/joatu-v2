class DashboardController < ApplicationController

  NullObject = Naught.build
  include NullObject::Conversions
  extend NullObject::Conversions

  before_filter :authenticate_user!

  # Displays a dashboard page customized for the currently logged in user:
  def index
    # TODO: Base this on a saved user setting, so that once hidden it does
    # not reappear:
    @display_intro = true

    # The dashboard page is focused around the user's Pod, and any activity
    # taking place within it:
    @pod = Actual(Pod.home_pod_for_user(current_user))
    if @pod
      @pod_offers_and_requests = OfferOrRequest.summary_for_pod(@pod)
    end

    # The dashboard will also prominently display a list of the user's
    # organizations, with links to the org page for more details:
    @organizations = Organization.where_user_is_member(current_user)

    # Finally, the dashboard will display a list of events the user has been
    # invited to or chosen to attend:
    @events = Event.invited_or_attending(current_user)
  end
end

