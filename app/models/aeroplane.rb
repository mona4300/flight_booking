class Aeroplane < ApplicationRecord
  has_many :aeroplane_classes, dependent: :destroy

  has_many :flights, dependent: :restrict_with_error
  has_many :flight_classes, dependent: :restrict_with_error

  validates :name, presence: true

  def flights?
    flights.exists?
  end
end
