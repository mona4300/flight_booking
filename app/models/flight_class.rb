class FlightClass < ApplicationRecord
  belongs_to :aeroplane
  belongs_to :flight
  belongs_to :aeroplane_class

  validates :seat_price, presence: true, numericality: { greater_than: 0 }
end
