module Admins
  class FlightsController < ApplicationController
    before_action :set_flight, only: %i[ show edit update destroy ]
    before_action :check_changing_ability, only: %i[edit update destroy]

    # GET /flights or /flights.json
    def index
      @flights = Flight.all
    end
  
    # GET /flights/1 or /flights/1.json
    def show
    end
  
    # GET /flights/new
    def new
      @flight = Flight.new
    end
  
    # GET /flights/1/edit
    def edit
    end
  
    # POST /flights or /flights.json
    def create
      @flight = Flight.new(flight_params)
  
        if @flight.save
          redirect_to admins_flight_url(@flight), notice: "Flight was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
    end
  
    # PATCH/PUT /flights/1 or /flights/1.json
    def update
      if @flight.update(flight_params)
        redirect_to admins_flight_url(@flight), notice: "Flight was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /flights/1 or /flights/1.json
    def destroy
      @flight.destroy
  
      redirect_to admins_flights_url, notice: "Flight was successfully destroyed."
    end
  
    private

    def check_changing_ability
      return true unless @flight.reservations?

      redirect_to admins_flight_url(@flight), error: "Flight has reservations and couldn't be changed"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
      @breadcrumbs[:flight] = @flight
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.require(:flight).permit(:name, :aeroplane_id, :departure_date)
    end
  end  
end