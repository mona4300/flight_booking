class CreateAeroplaneClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :aeroplane_classes do |t|
      t.string :category
      t.integer :rows_number
      t.integer :seats_per_row
      t.decimal :seat_price
      t.integer :position
      t.integer :total_seats

      t.references :aeroplane, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
