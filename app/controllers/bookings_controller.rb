class BookingsController < ApplicationController
  def new
    @bus = Bus.find(params[:bus_id])
   @booking = Booking.new
  end
  def create
    @bus = Bus.find(params[:bus_id])
     render partial: "popup", locals: { booking: @booking }
     
    @booking = @bus.bookings.new(booking_params)
   end
   private
   def booking_params
     params.permit(:seat_number, :bus_id)
   end
end
