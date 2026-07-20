class CreateBuses < ActiveRecord::Migration[8.1]
  def change
    create_table :buses do |t|
      t.string :bus_name
      t.string :bus_number
      t.string :source
      t.string :destination
      t.integer :total_seat
      t.integer :available_seat
      t.datetime :departure_at
      t.datetime :arrival_at
      t.integer :thumbnail_image_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
