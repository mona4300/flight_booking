module Passengers
  class FlightReservationsController < ApplicationController
    before_action :set_flight_reservation, :set_flight_seats, only: %i[edit update]
    before_action :set_flight_seat, only: :update
    before_action :init_flight_reservation, :check_seats_availability, only: :create
    before_action :init_upcoming_flights, only: :create

    def edit; end

    def update
      if @flight_reservation.update(flight_seat: @flight_seat)
        redirect_to root_url, notice: 'Flight Reservation was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      if @flight_reservation.save
        redirect_to(
          root_url,
          notice: 'Flight Reservation was successfully created.'\
                  " and your PNR is #{@flight_reservation.pnr}" \
                  " and Price equals #{@flight_reservation.flight_class.seat_price}"
        )
      else
        render 'passengers/home/index', status: :unprocessable_entity
      end
    end

    protected

    def set_flight_seat
      @flight_seat = FlightSeat.find(params[:flight_seat_id])

      available_seat = @flight_seat.flight_class_id == @flight_reservation.flight_class_id
      available_seat ||= @flight_seat.flight.empty_seats?(@flight_seat.flight_class)
      return if available_seat

      redirect_to root_url, error: 'No Seats Available for this class'
    rescue ActiveRecord::RecordNotFound
      redirect_to edit_passengers_flight_reservation_path, error: 'Flight Seat not valid!!'
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
      redirect_to root_url, error: 'Flight Reservation not found!!'
    end

    def init_flight_reservation
      @flight_reservation = FlightReservation.new(flight_reservation_params)

      @flight_reservation.flight = Flight.upcoming.find(flight_id_param)
      @flight_reservation.flight_class =
        @flight_reservation.flight.flight_classes.find(
          flight_class_id_param
        )
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, error: 'Flight or Flight Class not valid'
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

      redirect_to root_url, error: 'No Seats Available for this class'
    end
  end
end
