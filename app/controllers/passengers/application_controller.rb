module Passengers
  class ApplicationController < ::ApplicationController
    protected

    def init_upcoming_flights
      @flights = Flight.upcoming
    end
  end
end
