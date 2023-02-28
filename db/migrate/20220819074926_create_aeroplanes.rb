class CreateAeroplanes < ActiveRecord::Migration[7.0]
  def change
    create_table :aeroplanes do |t|
      t.string :name

      t.timestamps
    end
  end
end
