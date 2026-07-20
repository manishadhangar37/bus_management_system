class SessionsController < ApplicationController
    
    def new
       
    end
    def create
        user = User.find_by(email: params[:email])
        return if user.nil?
        if user&.authenticate(params[:password]) && user.email_varified 
            token = JwtService.new.generate_token(user)
            if token
                cookies[:jwt] = {
                    value: token
                }
                
                redirect_to '/'
           
            end
        else
            redirect_to login_path
        end
    
    end

    def destroy
        session.clear
        cookies.delete(:jwt)
        redirect_to login_path
    end
end
