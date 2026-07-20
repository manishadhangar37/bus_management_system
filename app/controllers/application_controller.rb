class ApplicationController < ActionController::Base
 before_action :check_authenticate_token
 
 private
 def check_authenticate_token
  return if controller_name == "users"
  return if controller_name == "sessions"
  
   token = cookies[:jwt]
   
    if token.nil?
      redirect_to login_path
      return
    end
    
    begin
      decoded = JWT.decode(
      token,
      Rails.application.secret_key_base,
      true,
      algorithm:"HS256"
      )
      current_user_id=(decoded[0]["user_id"])
      cookies[:user_id] = {
                    value: current_user_id}
                  rescue
                    cookies.delete(:jwt)
                    redirect_to login_path
    
    end
  end

end
