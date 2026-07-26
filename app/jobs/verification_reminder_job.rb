class VerificationReminderJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    return unless user
    return unless user.varified

    UserMailer.varification_reminder(user).deliver_now
    
  end
end
