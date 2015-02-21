class PodListener
  NullObject = Naught.build
  include NullObject::Conversions

  def user_location_updated(user)
    best_pod = Pod.best_for_user(user)
    return unless Actual(best_pod)
    
    home_membership = PodMembership.home_membership_for_user(user)
    home_membership.pod = best_pod
    home_membership.save!
  end
end
