class UsersController < ApplicationController
    skip_before_action  :check_authenticate_token, only: [ :new, :create ]


    def new
        @user = User.new
    end
    def show
       @user = @current_user
    end

    def create
        @user = User.new(user_params)

        if @user.save
           UserMailer.welcome_email(@user).deliver_now
           flash[:notice]="user registered now check your email to varify your account"
           VerificationReminderJob.set(wait_until: 2.minute.from_now).perform_later(@user_id)
           VerificationReminderJob.set(wait_until: 3.minute.from_now).perform_later(@user_id)
           VerificationReminderJob.set(wait: 5.day).perform_later(@user_id)


           redirect_to login_path
        else
            render :new, status: :unprocessable_entity
        end
    end


    private
    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :role, :gender, :contact)
    end
end
