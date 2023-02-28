class AeroplaneClass < ApplicationRecord
  belongs_to :aeroplane

  has_many :flight_classes, dependent: :restrict_with_error

  validates :category, :rows_number, :seats_per_row, :seat_price,
            :position, presence: true

  validates :rows_number, :seats_per_row, :position, numericality: { only_integer: true }
  validates :rows_number, :seats_per_row, :seat_price, numericality: { greater_than: 0 }
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  before_create :sync_total_seats

  protected

  def sync_total_seats
    self.total_seats = seats_per_row * rows_number
  end
end
