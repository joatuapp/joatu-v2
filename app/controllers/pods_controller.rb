class PodsController < InheritedResources::Base

  # Show's the user's home pod.
  def home
    @pod = current_user.home_pod
    authorize @pod, :show?
    render :show
  end
end

