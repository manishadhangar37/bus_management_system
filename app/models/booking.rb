class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bus
 
  validates :booking_date,presence: true
  validates :seat_number,presence: true
  validates :total_ticket,  numericality: { less_than_or_equal_to: 3,message: "can book less then one 3 seat " }
  
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
    def check_booked_seats(booked_date,bus)
      
     seats = Booking.where(bus_id: bus.id, booking_date: booked_date).pluck(:seat_number).flatten
   
  
    end

  


  def decrease_total_seat
   bus.total_seat - self.total_ticket
  end

  def self.for_admin(user)
   joins(:bus).where(buses: { user_id: user.id })
  end
  
end
