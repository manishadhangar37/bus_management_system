class Bus < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validates :bus_name,presence:true
  validates :bus_number,presence:true,format: {with:/\A MP-\d{2}-[A-Z]-\d{4}}\z/}
  validates :total_seat,numericality: {greater_than_or_equal_to:45,less_than_or_equal_to:55}
  validates :source_and_destination_diff
  validates :arrival_time_must_greater_to_departure_time

  def source_and_destination_diff
    if source == destination
      errrs.add(destination: "source and destination must be different")
    end
  end

  def arrival_time_must_greater_to_departure_time
    if arrival_at < departure_at 
      errors.add(arrival: "arrival must greater than departure")
    end
  end


 

end
