class UserMailer < ApplicationMailer
    default from: "manishad@shriffle.com"
    def welcome_email(user)
        @user = user
        mail(
            to: @user.email,
            subject: "welcome to app"
        )
    end

    def varification_reminder(user)
        @user = user
        mail(
            to: @user.email,
            subject: "reminder email"

        )
    end
end
