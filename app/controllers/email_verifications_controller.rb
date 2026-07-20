class EmailVerificationsController < ApplicationController
    def email_verify
        user = User.find_by(generate_token:params[:token])
        if user
            user.update_columns(generate_token: nil,email_varified: true)
        end
    end
        
end


