class BusesController < ApplicationController
  before_action :set_user

    def new
      @bus = Bus.new
    end

    def index
      @buses = Bus.all
    end

    def create
          # return unless @current_user.admin?
          @bus = @user.buses.new(bus_params)

        if @bus.save
            redirect_to users_path(@user), notice: "created"
        else
          render :new, status: :unprocessable_entity
        end
    end


    private
    def bus_params
      params.require(:bus).permit(:bus_name, :bus_number, :source, :destination, :arrival_at, :departure_at, :total_seat, images: [])
    end
    def set_user
      @user = User.find(params[:user_id])
    end
end
