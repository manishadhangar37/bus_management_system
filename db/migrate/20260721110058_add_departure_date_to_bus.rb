class AddDepartureDateToBus < ActiveRecord::Migration[8.1]
  def change
    add_column :buses, :departure_date, :date
  end
end
