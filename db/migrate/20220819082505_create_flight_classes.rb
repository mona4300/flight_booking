class CreateFlightClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_classes do |t|
      t.decimal :seat_price

      t.references :aeroplane_class, foreign_key: { on_delete: :restrict }
      t.references :flight, foreign_key: { on_delete: :cascade }
      t.references :aeroplane, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
