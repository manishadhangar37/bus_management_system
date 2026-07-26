class AdminsDashboardController < ApplicationController

    def admin
        @total_buses = Bus.count
        @total_users = User.count
        @total_bookings = Booking.count
        
    end
end