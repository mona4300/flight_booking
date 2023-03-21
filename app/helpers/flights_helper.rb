module FlightsHelper
  def money_diff(flight_reservation, flight_class)
    current_price = flight_reservation.flight_class.seat_price
    current_class_price = flight_class.seat_price

    current_class_price - current_price
  end

  def current_seat?(seat, reservation)
    seat.id == reservation.flight_seat_id
  end

  def seats_status(flight)
    flight.seats_ready ? t('yes') : t('no')
  end

  def disabled_seat?(seat, reservation)
    !(
      seat.id == reservation.flight_seat_id ||
        (
          reservation.flight_seat_id_changed? &&
          seat.id == reservation.flight_seat_id_was
        )
    ) && !seat.availability
  end
end
