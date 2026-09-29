class EventsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @events = Event.upcoming
  end
end
