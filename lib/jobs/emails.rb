module Jobs
  class SendOrderConfirmation
    @queue = :order_confirmation_emails
    def self.perform(order, invoice)
      Notifier.order_confirmation(order, invoice).deliver
    end
  end

  class SendPasswordResetInstructions
    @queue = :password_reset_emails
    def self.perform(user)
      Notifier.password_reset_instructions(user).deliver
    end
  end

  class SendSignUpNotification
    @queue = :signup_notification_emails
    def self.perform(recipient)
      Notifier.signup_notification(recipient).deliver
    end
  end
end
