class BusesController < ApplicationController
    before_action :set_user
    def new
      @bus = Bus.new
    end

    def index
      @buses = Bus.all
    end
    def show
      @bus = Bus.find(params[:id])
    end

     def create
             # return unless @current_user.admin?

             @bus = @user.buses.new(bus_params)

           if @bus.save
            redirect_to edit_user_bus_path(@user, @bus)
           else
              render :new, status: :unprocessable_entity
           end
          end

    def edit
       @bus = @user.buses.find(params[:id])
    end

    def update
       @bus = Bus.find(params[:id])

       @bus.update(bus_params)
       @bus.update(thumbnail_image_id: params[:bus][:thumbnail_image_id])

       redirect_to "/"
    end
    def destroy
      @bus = Bus.find(params[:id])
      @bus.destroy
      redirect_to "/"
    end



    private
    def bus_params
      params.require(:bus).permit(:bus_name, :bus_number, :source, :destination, :arrival_at, :departure_at, :thumbnail_image_id, :total_seat, images: [])
    end
    def set_user
      @user = User.find(params[:user_id])
    end
end
