class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bus
 
  validates :booking_date,presence: true
  validates :total_ticket,  numericality: { less_than_or_equal_to: 3,message: "can book less then one 3 seat " }
  validate :booking_date_greater_than_today
  after_create :decrease_total_seat
  
  def check_prior_seat(seats)
    seats.each do |s|
      bus_ide = bus.id
      book_date = self.booking_date
      seat  = Booking.where(bus_id: bus_ide,booking_date: book_date).where("? = ANY(seat_number)", s)
      return unless seat
      
        
     end
    end

  def booking_date_greater_than_today
    if booking_date < Date.today
         errors.add(:booking_date, "booking date must be greater then today")
    end
  end

  def decrease_total_seat
   bus.total_seat - self.total_ticket
  end
  
end
