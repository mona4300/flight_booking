module Passengers
  class HomeController < ApplicationController
    def index
      @flight_reservation = FlightReservation.new
    end
  end
end
