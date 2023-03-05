module Passengers
  class HomeController < ApplicationController
    before_action :init_upcoming_flights

    def index
      @flight_reservation = FlightReservation.new
    end
  end
end
