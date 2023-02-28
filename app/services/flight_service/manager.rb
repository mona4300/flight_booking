module FlightService
  class Manager
    attr_accessor :flight, :aeroplane

    def initialize(flight:)
      @flight = flight
      @aeroplane = flight.aeroplane
    end

    def prepare
      ActiveRecord::Base.transaction do
        remove_old_values
        create_seats_and_classes

        flight.update seats_ready: true
      end
    end

    protected

    def remove_old_values
      flight.flight_classes.destroy_all
      flight.flight_seats.destroy_all
    end

    def create_seats_and_classes
      aeroplane.aeroplane_classes.each_with_index do |aeroplane_class, index|
        flight_class = create_flight_class(aeroplane_class)
        create_flight_seats(flight_class, index)
      end
    end

    def create_flight_class(aeroplane_class)
      flight.flight_classes.create(
        seat_price: aeroplane_class.seat_price,
        aeroplane_class_id: aeroplane_class.id,
        aeroplane_id: aeroplane_class.aeroplane.id
      )
    end

    def create_flight_seats(flight_class, aeroplane_class_index)
      flight_class.aeroplane_class.rows_number.times do |row_index|
        flight_class.aeroplane_class.seats_per_row.times do |seat_index|
          FlightSeat.create(
            flight_class_id: flight_class.id, flight_id: flight.id,
            availability: true, position: flight_class.aeroplane_class.position,
            row_number: row_index, col_number: seat_index,
            name: "C#{aeroplane_class_index + 1}R#{row_index + 1}S#{seat_index + 1}"
          )
        end
      end
    end
  end
end
