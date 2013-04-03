module Jobs
  class SendOrderConfirmation
    @queue = :order_confirmation_emails
    def self.perform(order_id, invoice_id)
      order = Order.find(order_id)
      invoice = Invoice.find(invoice_id)
      Notifier.order_confirmation(order, invoice).deliver
    end
  end

  class SendPasswordResetInstructions
    @queue = :password_reset_emails
    def self.perform(user_id)
      user = User.find(user_id)
      Notifier.password_reset_instructions(user).deliver
    end
  end

  class SendSignUpNotification
    @queue = :signup_notification_emails
    def self.perform(user_id)
      recipient = User.find(user_id)
      Notifier.signup_notification(recipient).deliver
    end
  end
end
