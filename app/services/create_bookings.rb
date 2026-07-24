class CreateBookings
    def check_seats(seats)
    seats.each do |s|
      if Booking.where("? = ANY(seat_number)", 23)
       render plain:"seat number #{s}already booked" and return
      end
    end
   
    
    end
end