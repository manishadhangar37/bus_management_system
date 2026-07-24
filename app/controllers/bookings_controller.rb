class BookingsController < ApplicationController
before_action :set_booking

  def new
    @bus = Bus.find(params[:bus_id])
   @booking = Booking.new
  end
  def create
    @booking = @bus.bookings.new(booking_params)
    @booking.user = @current_user
    current_user =@current_user
    seats = params[:seat_number]
    seats.each do |s|
      if Booking.where("? = ANY(seat_number)", s).empty?
        
       render plain:"seat number #{s}  already booked" and return
      end
    end
    @booking.total_ticket = params[:seat_number].length
    @booking.status="confirmed"
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

   def set_booking
    @bus = Bus.find(params[:bus_id])
    end
end


