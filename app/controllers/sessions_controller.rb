class SessionsController < ApplicationController
    skip_before_action :check_authenticate_token

    def new
    end
    def create
        user = User.find_by(email: params[:email])
         if user.nil?
           flash.now[:alert]="enter valid email"
           render :new and return
         end
        if user.authenticate(params[:password])

            unless user.email_varified
                flash.now[:alert]="email is not varified"
                render :new and return
            end
            token = JwtService.new.generate_token(user)
            if token
                cookies[:jwt] = {
                    value: token,
                    expires: 24.hours.from_now, httponly: true
                }
               if user.admin?
                redirect_to admins_path
               else
                    redirect_to root_path
               end

            end
        else
           flash.now[:alert] = "invalid email/password"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        cookies.delete(:jwt)
        redirect_to login_path
    end
end
