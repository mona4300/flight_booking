module FlightsHelper
  def money_diff(flight_reservation, flight_class)
    current_price = flight_reservation.flight_class.seat_price
    current_class_price = flight_class.seat_price

    current_class_price - current_price
  end
end
