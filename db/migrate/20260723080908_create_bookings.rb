class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bus, null: false, foreign_key: true
      t.date :booking_date
      t.string :status
      t.integer :total_ticket

      t.timestamps
    end
  end
end
