class Notifier < ActionMailer::Base
  default :from => '"The UFCFIT team" <no-reply@ufcfit.com>'

  def order_confirmation(order,invoice)
    @invoice = invoice
    @order  = order
    @user   = order.user
    @url    = root_url
    @site_name = 'site_name'
    mail(:to => order.email,
         :subject => "Order Confirmation")
  end

  def password_reset_instructions(user)
    @user = user
    @url  = edit_customer_password_reset_url(:id => user.perishable_token)
    mail(:to => user.email,
         :subject => "Reset Password Instructions")
  end

  # Simple Welcome mailer
  # => CUSTOMIZE FOR YOUR OWN APP
  #
  # @param [user] user that signed up
  # => user must respond to email_address_with_name and name
  def signup_notification(recipient)
    @user = recipient
    @key  = UsersNewsletter.unsubscribe_key(@user.email)

    mail(:to => recipient.email_address_with_name,
         :subject => "Thank you for Subscribing!")

  end
end
