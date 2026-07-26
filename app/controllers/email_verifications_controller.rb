class EmailVerificationsController < ApplicationController
        skip_before_action :check_authenticate_token, only: [ :email_varify ]

    def email_varify
        user = User.find_by(generate_token: params[:token])
        if user
            user.update_columns(generate_token: nil, email_varified: true)
            redirect_to login_path, notice: "Email varification successufully"
        else
            redirect_to root_path
        end
    end
end
