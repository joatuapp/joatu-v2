class PodsController < InheritedResources::Base

  private

    def pod_params
      params.require(:pod).permit(:name, :description, :focus_area, :hub_id)
    end
end

