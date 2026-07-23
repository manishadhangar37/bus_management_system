class SessionsController < ApplicationController
    skip_before_action :check_authenticate_token, only: [ :new, :create ]

    def new
    end
    def create
        user = User.find_by(email: params[:email])
         if user.nil?
           flash.now[:alert]="enter email first"
           render :new and return
         end
        if user&.authenticate(params[:password]) && user.email_varified
            token = JwtService.new.generate_token(user)
            if token
                cookies[:jwt] = {
                    value: token
                }

                redirect_to "/", notice: "login successfully"

            end
        else
           flash.now[:alert] = "invalid email/password"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session.clear
        cookies.delete(:jwt)
        redirect_to login_path
    end
end
