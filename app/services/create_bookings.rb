class CreateBookings
  def initialize(bus,user,params)
    @user = user
    @bus = bus
    @params =params
  
  end
    def complete_booking
      seats=@params[:seat_number]
      
    booking = @bus.bookings.new(@params)
    booking.user=@user
    
    booking.status="confirmed"
     booking

    
    end
end