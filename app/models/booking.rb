class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bus
 
  validates :booking_date,presence: true
  validates :seat_number,presence: true
  validates :total_ticket,  numericality: { less_than_or_equal_to: 3,message: "can book less then one 3 seat " }
  validate :booking_date_greater_than_today
  after_create :decrease_total_seat
  
  def check_prior_seat(seats)
    seat_present=[]
    seats.each do |s|
      bus_ide = bus.id
      book_date = self.booking_date
      seat  = Booking.where(bus_id: bus_ide,booking_date: book_date).where("? = ANY(seat_number)", s).exists?
      if seat
        seat_present.push(s)
      end
    end
    seat_present
    end
    def check_booked_seats
      
     seats = Booking.where(bus_id: 29, booking_date: Date.today).pluck(:seat_number)

  
    end

  def booking_date_greater_than_today
    if booking_date < Date.today
         errors.add(:booking_date, "booking date must be greater then today")
    end
  end


  def decrease_total_seat
   bus.total_seat - self.total_ticket
  end

  def self.for_admin(user)
   joins(:bus).where(buses: { user_id: user.id })
  end
  
end
