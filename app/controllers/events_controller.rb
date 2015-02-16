class EventsController < ApplicationController

  private

    def event_params
      params.require(:event).permit(:name, :description, :starts_at, :ends_at)
    end
end

