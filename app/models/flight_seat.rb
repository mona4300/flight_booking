class FlightSeat < ApplicationRecord
  belongs_to :flight
  belongs_to :flight_class
  has_one :flight_reservation

  validates :name, :position, :row_number, :col_number, presence: true
end
