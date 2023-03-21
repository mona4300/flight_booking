module Admins
  class FlightClassesController < ApplicationController
    before_action :set_flight_class, :check_changing_ability, only: %i[edit update]

    helper_method :resource_klass

    # GET /flight_classes/1/edit
    def edit; end

    # PATCH/PUT /flight_classes/1 or /flight_classes/1.json
    def update
      if @flight_class.update(flight_class_params)
        redirect_to admins_flight_url(@flight_class.flight),
                    notice: success_message(resource_klass, :update)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def resource_klass
      FlightClass
    end

    def check_changing_ability
      return true unless @flight_class.flight.reservations?

      redirect_to admins_flight_url(@flight_class.flight), error: t('admins.flights.errors.reservations_exists')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_flight_class
      @flight_class = FlightClass.find(params[:id])
      @breadcrumbs.merge!(
        flight: { id: @flight_class.flight.id, name: @flight_class.flight.name },
        flight_class: { id: @flight_class.id, name: @flight_class.name }
      )
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
