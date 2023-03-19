module Passengers
  class ApplicationController < ::ApplicationController
    protected

    def init_upcoming_flights
      @flights = Flight.upcoming.includes(flight_classes: :aeroplane_class)
    end
  end
end
