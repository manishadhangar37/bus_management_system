class BookingsController < ApplicationController
before_action :set_bus, except: [:index]

def index 
  @bookings = Booking.for_admin(@current_user).page(params[:page]).per(10)

end
def show
end
def new
   @booking = Booking.new
   if params[:booking_date].present?
   booking_date = params[:booking_date]
  else
    booking_date = Date.today
   end 
   @booking_date = booking_date
   @seat = @booking.check_booked_seats(@booking_date,@bus)
  end

  def create
  seats=params[:seat_number]
    unless seats.present?
      flash[:notice]="choose any seat"
      redirect_to new_bus_booking_path(@bus) and return
    end
      @booking = CreateBookings.new(@bus,@current_user,booking_params).complete_booking
      seat_present = @booking.check_prior_seat(seats)
      
      if seat_present.any?  
       flash[:already]="#{seat_present.join(',')} already booked"
       redirect_to new_bus_booking_path(@bus) and return
      end
    @booking.total_ticket=seats.count
    if @booking.save
      BookingMailer.confirm_booking_message(@booking,@current_user).deliver_now
     flash[:notice]= "booking confirm you can check mail"
     redirect_to new_bus_booking_path(@bus)
    
    else
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


