class CreateBookings
  def initialize(bus,user,params)
    @user = user
    @bus = bus
    @params =params
  end
    def complete_booking
      seats=@params[:seat_number]
      seats.each do |s|
        if Booking.where(bus_id:@bus.id,booking_date: @params[:booking_date]).where("? = ANY(seat_number)", s).exists?
        raise "Seat number #{s} already booked"
      end
    end
    booking = @bus.bookings.new(@params)
    booking.user=@user
    booking.total_ticket=seats.length
    booking.status="confirmed"
     booking

    
    end
end