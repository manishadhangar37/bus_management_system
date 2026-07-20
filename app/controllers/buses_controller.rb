class BusesController < ApplicationController
    include CheakUserRole
    def new
        @bus = Bus.new
    end
    
    def index
        @buses = Bus.all
    end

    def create
        bus = Bus.new(bus_params)

        if bus.save
            redirect_to buses_path
        end

    end
    private
    def bus_params
        params.require(:bus).permit(:bus_name,:bus_number,:source,:destination,:arrival_at,:departure_at,:total_seat,:available_seat)
    end

end
