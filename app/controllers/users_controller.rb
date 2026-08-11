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
           VerificationReminderJob.set(wait_until: 2.minute.from_now).perform_later(@user)
           VerificationReminderJob.set(wait_until: 3.minute.from_now).perform_later(@user)
           VerificationReminderJob.set(wait: 5.day).perform_later(@user)


           redirect_to login_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def reset_password
     unless params[:new_password]==params[:confirm_password]
         render plain: "new and confirm does not match" and return
     end
     if @current_user.authenticate(params[:old_password])
        new_password_hashed = BCrypt::Password.create(params[:new_password])
        if @current_user.update_columns(password_digest: new_password_hashed)
          render plain: "password changed"
        else
            render plain: "failed"
        end
     end
    end




    private
    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :role, :gender, :contact)
    end
end
