class Flight < ApplicationRecord
  belongs_to :aeroplane

  has_many :flight_classes, dependent: :destroy
  has_many :flight_seats, dependent: :destroy

  has_many :flight_reservations, dependent: :restrict_with_error

  after_commit :prepare_seats_prices, if: :saved_change_to_aeroplane_id?

  validates :name, presence: true

  def reservations?
    !seats_ready || flight_reservations.exists?
  end

  def empty_seats?(flight_class)
    flight_reservations.where(
      flight_id: id, flight_class_id: flight_class.id
    ).count < flight_class.aeroplane_class.total_seats
  end

  private

  def prepare_seats_prices
    update_columns(seats_ready: false)

    # CreateSeatsClassesWorker.perform_async(id)
    CreateSeatsClassesWorker.new.perform(id)
  end
end
