class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :name
      t.boolean :seats_ready

      t.references :aeroplane, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
