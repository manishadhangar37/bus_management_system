class AddSeatNumberToBooking < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :seat_number, :integer, array: true, default: []
  end
end
