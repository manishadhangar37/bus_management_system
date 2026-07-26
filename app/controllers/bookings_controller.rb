class BookingsController < ApplicationController
before_action :set_bus, except: [:index]

def index 
  @bookings = Booking.all
end
def show
end
def new
    @bus = Bus.find(params[:bus_id])
   @booking = Booking.new
  end
  def create
    @booking = CreateBookings.new(@bus,@current_user,booking_params).complete_booking
    if @booking.save
      BookingMailer.confirm_booking_message(@booking,@current_user).deliver_now
      render plain:"booked"
     end
  end

  def edit
     @booking = @bus.bookings.find(params[:id])
  end

  def update
    
  end
   private
   def booking_params
     params.permit(:bus_id,:booking_date,seat_number: [])
   end

   def set_bus
    @bus = Bus.find(params[:bus_id])
  end
end


