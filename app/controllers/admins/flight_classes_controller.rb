module Admins
  class FlightClassesController < ApplicationController
    before_action :set_flight_class, :check_changing_ability, only: %i[edit update]

    # GET /flight_classes/1/edit
    def edit; end

    # PATCH/PUT /flight_classes/1 or /flight_classes/1.json
    def update
      if @flight_class.update(flight_class_params)
        redirect_to admins_flight_url(@flight_class.flight), notice: "Flight class was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def check_changing_ability
      return true unless @flight_class.flight.reservations?

      redirect_to admins_flight_url(@flight_class.flight), error: "Flight has reservations and couldn't be changed"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_flight_class
      @flight_class = FlightClass.find(params[:id])
      @breadcrumbs.merge!(flight: @flight_class.flight, flight_class: @flight_class)
    end

    # Only allow a list of trusted parameters through.
    def flight_class_params
      params.fetch(:flight_class, {}).permit(:seat_price)
    end

    def flight_id_param
      params.require(:flight_class).fetch(:flight_id)
    end
  end
end
