class BookingsController < ApplicationController
before_action :set_bus, except: [:index]

def index 
  @bookings = Booking.all
end
def show
end
def new
   @booking = Booking.new
  end

  def create
  seats=params[:seat_number]

    unless seats.present?
      flash[:notice]="choose any seat"
      redirect_to new_bus_booking_path(@bus) and return
    end

    
     
     @booking = CreateBookings.new(@bus,@current_user,booking_params).complete_booking
      message = @booking.check_prior_seat(seats)
      @booking.seat_number = message
      flash[:already]=message
    redirect_to new_bus_booking_path(@bus) and return
    @booking.total_ticket=seats.count
    if @booking.save
      BookingMailer.confirm_booking_message(@booking,@current_user).deliver_now
     flash[:notice]= "booking confirm you can check mail"
     redirect_to new_bus_booking_path(@bus)
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


