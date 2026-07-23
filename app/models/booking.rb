class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bus
 
  
  validates :total_ticket,  numericality: { greater_than_or_equal_to: 3 }
  validate :booking_date_greater_than_today
  after_create :decrease_total_seat
  def booking_date_greater_than_today
   if booking_date < Date.today
         errors.add(:booking_date, "booking date must be greater then today")

   end
  end
  def decrease_total_seat
    user.total_seat-=total_ticket
  end
  
end
