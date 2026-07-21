class ApplicationController < ActionController::Base
 before_action :check_authenticate_token

 private
 def check_authenticate_token
   token = cookies[:jwt]
   if token.nil?
      redirect_to login_path
   end
   begin
    decoded = JWT.decode(token,
      Rails.application.secret_key_base,
      true,
      algorithm: "HS256"
      )

      @current_user = User.find(decoded[0]["user_id"])
    rescue
      cookies.delete(:jwt)
      redirect_to login_path
    end
  end
end
