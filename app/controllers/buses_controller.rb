class BusesController < ApplicationController
    before_action :set_user, only: [:create, :update, :edit,:destroy]
    def new
      @bus = Bus.new
    end

    def index
      @buses = Bus.all.page(params[:page]).per(10)
    end
    def show
    
      @bus = Bus.find(params[:id])
    end

     def create
      return unless @current_user.admin?
      @bus = @user.buses.new(bus_params)
      if @bus.save
            redirect_to edit_bus_path(@bus)
           else
              render :new, status: :unprocessable_entity
           end
          end

    def edit
       @bus = Bus.find(params[:id])
    end

    def update
       @bus = Bus.find(params[:id])
       @bus.update(bus_params)
       @bus.update(thumbnail_image_id: params[:bus][:thumbnail_image_id])
        
    
    redirect_to admins_path
    end
    def destroy
     return unless @user.admin
      @bus = Bus.find(params[:id])
      @bus.destroy
      redirect_to "/"
    end
    def search
      source = params[:source]
      destination = params[:destination]
      @buses = Bus.search(source,destination)
      
    end

    private
    def bus_params
      params.require(:bus).permit(:bus_name, :bus_number, :source, :destination, :arrival_at, :departure_at, :thumbnail_image_id, :total_seat, images: [])
    end
    def set_user
      @user = @current_user
    end
end
