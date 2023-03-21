class FlightClass < ApplicationRecord
  belongs_to :aeroplane
  belongs_to :flight
  belongs_to :aeroplane_class

  validates :seat_price, presence: true, numericality: { greater_than: 0 }

  delegate :name, to: :aeroplane_class

  scope :order_position, -> {
    joins(:aeroplane_class).order('aeroplane_classes.position' => :asc)
  }

end
