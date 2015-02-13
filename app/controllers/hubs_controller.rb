class HubsController < InheritedResources::Base

  private

    def hub_params
      params.require(:hub).permit(:name, :description, :latlng)
    end
end

