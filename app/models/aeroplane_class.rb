class AeroplaneClass < ApplicationRecord
  MAX_SEATS_ROWS = 11.freeze

  belongs_to :aeroplane

  has_many :flight_classes, dependent: :restrict_with_error

  validates :category, :rows_number, :seats_per_row, :seat_price,
            :position, presence: true

  validates :rows_number, :seats_per_row, :position,
            numericality: { only_integer: true }

  validates :rows_number, :seats_per_row, numericality: { less_than: MAX_SEATS_ROWS }

  validates :rows_number, :seats_per_row, :seat_price,
            numericality: { greater_than: 0 }

  validates :position,
            numericality: { greater_than_or_equal_to: 0 },
            uniqueness: { scope: :aeroplane_id }

  before_save :sync_total_seats, if: lambda {
    rows_number_changed? || seats_per_row_changed?
  }

  alias_attribute :name, :category

  scope :order_position, -> { order(position: :asc) }

  protected

  def sync_total_seats
    self.total_seats = seats_per_row * rows_number
  end
end
