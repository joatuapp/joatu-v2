class RequestsController < InheritedResources::Base

  private

    def request_params
      params.require(:request).permit()
    end
end

