class FlightReservation < ApplicationRecord
  PNR_LENGTH = 8

  belongs_to :flight
  belongs_to :flight_class
  belongs_to :flight_seat, optional: true

  before_validation :generate_pnr, on: :create, if: -> { pnr.nil? }

  after_save :sync_flight_seat, if: -> { saved_change_to_flight_seat_id? }

  validates :pnr, :user_name, uniqueness: { scope: :flight_id }, presence: true

  protected

  def generate_pnr
    self.pnr = SecureRandom.alphanumeric(PNR_LENGTH)
  end

  def sync_flight_seat
    FlightSeat.find_by_id(flight_seat_id_before_last_save)&.update(availability: true)
    flight_seat.update availability: false

    update_columns(flight_class_id: flight_seat.flight_class.id)
  end
end
