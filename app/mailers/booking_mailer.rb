class BookingMailer < ApplicationMailer
    default from: "manishad@shriffle.com"
    def confirm_booking_message(bookings,user)
         @user=user
         @bookings=bookings
        mail(
           
            to: user.email,
            subject: "Booking Confirm"
        )
    end
end
