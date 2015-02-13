class PodsController < InheritedResources::Base

  # Show's the user's home pod.
  def home
    @pod = current_user.home_pod
    render :show
  end
end

