class EventsController < ApplicationController

  respond_to :html

  def show
    @event = Event.find(params[:id])
    authorize @event
    respond_with(@event)
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :starts_at, :ends_at)
    end
end

