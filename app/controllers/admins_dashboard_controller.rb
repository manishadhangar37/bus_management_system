class AdminsDashboardController < ApplicationController
before_action :check_admin
    def admin
        @total_buses = @current_user.buses.count
        current_user = @current_user
        total = Booking.for_admin(current_user).count
       
        
        if total
            @total_bookings=total
        else
        render plain: "no booking"
        end
        
    end

    def index
        @buses = @current_user.buses.page(params[:page]).per(10)
    end
    def check_admin
        
       unless @current_user.admin?
         redirect_to root_path
       end
    end
    def search_bus
        search = params
    end
  
end