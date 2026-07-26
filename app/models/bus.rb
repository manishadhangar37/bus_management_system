class Bus < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :bookings


  validates :bus_name, presence: true
  validates :bus_number, presence: true, format: { with:  /\A[A-Z]{2}-\d{2}-[A-Z]{2}-\d{4}\z/, message: "bus number must in these format MP-09-FA-1234" }
  validates :total_seat, numericality: { greater_than_or_equal_to: 45, less_than_or_equal_to: 55,  message: "must be between 45 and 55" }
  validate :source_and_destination_diff
  validate :arrival_time_must_greater_to_departure_time
  validates :images, limit: { min: 5, message: "must contain  5 image files" }
  after_save :set_availabel_seat
  private
  def source_and_destination_diff
    if source == destination
      errors.add(:destination, "source and destination must be different")
    end
  end

  def arrival_time_must_greater_to_departure_time
    if arrival_at < departure_at
      errors.add(:arrival, "arrival must greater than departure")
    end
  end
  def set_availabel_seat
    self.available_seat = self.total_seat
  end
  
end
