module Passengers
  class FlightReservationsController < ApplicationController
    before_action :set_flight_reservation, :set_flight_seats, only: %i[edit update]
    before_action :set_flight_seat, only: :update
    before_action :init_flight_reservation, :check_seats_availability, only: :create
    before_action :init_upcoming_flights, only: :create

    helper_method :resource_klass

    def edit; end

    def update
      if @flight_reservation.update(flight_seat: @flight_seat)
        redirect_to root_url,
                    notice: success_message(resource_klass, :update)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      if @flight_reservation.save
        redirect_to(
          root_url,
          notice: t(
            '.success',
            pnr: @flight_reservation.pnr,
            price: @flight_reservation.flight_class.seat_price
          )
        )
      else
        render 'passengers/home/index', status: :unprocessable_entity
      end
    end

    protected


    def resource_klass
      FlightReservation
    end

    def set_flight_seat
      @flight_seat = FlightSeat.find(params[:flight_seat_id])

      available_seat = @flight_seat.flight_class_id == @flight_reservation.flight_class_id
      available_seat ||= @flight_seat.flight.empty_seats?(@flight_seat.flight_class)
      return if available_seat

      redirect_to request.referrer, error: t('passengers.flight_classes.errors.no_seats')
    rescue ActiveRecord::RecordNotFound
      redirect_to request.referrer, error: t('passengers.flight_seats.errors.invalid')
    end

    def set_flight_seats
      @flight_seats = @flight_reservation.flight.flight_seats.includes(
        :flight_class
      ).order(:position, :row_number, :col_number)
    end

    def set_flight_reservation
      @flight_reservation = FlightReservation.find_by!(
        flight_id: params[:flight_id],
        pnr: params[:pnr]
      )
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, error: t('passengers.flight_reservations.errors.invalid')
    end

    def init_flight_reservation
      @flight_reservation = FlightReservation.new(flight_reservation_params)

      @flight_reservation.flight = Flight.upcoming.find(flight_id_param)
      @flight_reservation.flight_class =
        @flight_reservation.flight.flight_classes.find(
          flight_class_id_param
        )
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, error: t('passengers.flights.errors.invalid')
    end

    def flight_reservation_params
      params.require(:flight_reservation).permit(:user_name)
    end

    def flight_id_param
      params.require(:flight_reservation).fetch(:flight_id)
    end

    def flight_class_id_param
      params.require(:flight_reservation).fetch(:flight_class_id)
    end

    def check_seats_availability
      return if @flight_reservation.flight.empty_seats?(@flight_reservation.flight_class)

      redirect_to root_url, error: t('passengers.flight_classes.errors.no_seats')
    end
  end
end
