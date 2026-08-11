class VerificationReminderJob < ApplicationJob
  queue_as :default

  def perform(user)
   return if user.email_varified

    UserMailer.varification_reminder(user).deliver_now
  end
end
