class CreateFlightSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_seats do |t|
      t.references :flight_class
      t.references :flight

      t.boolean :availability
      t.string :name
      t.integer :position
      t.integer :row_number
      t.integer :col_number

      t.timestamps
    end
  end
end
