task reservations: :environment do
  flight = Flight.find_by_name('Flight1')

  flight.flight_reservations.create!(
    [
      { user_name: 'User 1 Name', flight:, flight_class: flight.flight_classes[0] },
      { user_name: 'User 2 Name', flight:, flight_class: flight.flight_classes[1] },
      { user_name: 'User 3 Name', flight:, flight_class: flight.flight_classes[2] }
    ]
  )
end
