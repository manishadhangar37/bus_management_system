class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
       
        if @user.save
           UserMailer.welcome_email(@user).deliver_now
           redirect_to login_path 
        else
            render :new, status: :unprocessable_entity 
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation,:role,:gender,:contact)
    end
end
