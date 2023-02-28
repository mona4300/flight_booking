class CreateFlightReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_reservations do |t|
      t.string :user_name
      t.string :pnr

      t.references :flight, foreign_key: { on_delete: :restrict }
      t.references :flight_seat
      t.references :flight_class

      t.timestamps
    end
  end
end
