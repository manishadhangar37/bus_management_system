class EmailVerificationsController < ApplicationController
        skip_before_action :check_authenticate_token, only: [ :varify ]

    def email_verify
        user = User.find_by(generate_token: params[:token])
        if user
            user.update_columns(generate_token: nil, email_varified: true)
        end
    end
end
