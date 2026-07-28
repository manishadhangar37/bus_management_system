class AdminsDashboardController < ApplicationController

    def admin
        @total_buses = @current_user.buses.count
        current_user = @current_user
        total = Booking.for_admin(current_user).count
        @buses = Bus.bus_for_admin(current_user)
        
        if total
            @total_bookings=total
    
        else
        render plain: "no booking"
        end
        
    end
end