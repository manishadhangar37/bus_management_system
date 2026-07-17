class UserMailer < ApplicationMailer
    default from: "manishad@shriffle.com"
    def welcome_email(user)
        @user = user
        mail(
            to: @user.email,
            subject: "welcome to app"
        )
    end
    
    
    

end
