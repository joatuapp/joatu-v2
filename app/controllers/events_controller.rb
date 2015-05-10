class EventsController < ApplicationController

  respond_to :html

  def show
    @event = Event.find(params[:id])
    authorize @event
    respond_with @event
  end
end

