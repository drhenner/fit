class Notifier < ActionMailer::Base
  default :from => '"The UFCFIT team" <no-reply@ufcfit.com>'

  def order_confirmation(order_id,invoice_id)
    @invoice = Invoice.find(invoice_id)
    @order  = Order.find(order_id)
    @user   = @order.user
    @key    = UsersNewsletter.unsubscribe_key(@user.email)
    @url    = root_url
    @site_name = 'site_name'
    mail(:to => @order.email,
         :subject => "Order Confirmation")
  end

  def order_cancelled_notification(order_id)
    @order  = Order.find(order_id)
    @user   = @order.user
    @key    = UsersNewsletter.unsubscribe_key(@user.email)
    mail(:to => @order.email,
     :subject => "Order Cancelled")
  end

  def password_reset_instructions(user_id)
    @user = User.find(user_id)
    @key  = UsersNewsletter.unsubscribe_key(@user.email)
    @url  = edit_customer_password_reset_url(:id => @user.perishable_token)
    mail(:to => @user.email,
         :subject => "Reset Password Instructions")
  end

  # Simple Welcome mailer
  # => CUSTOMIZE FOR YOUR OWN APP
  #
  # @param [user] user that signed up
  # => user must respond to email_address_with_name and name
  def signup_notification(recipient_id)
    @user = User.find(recipient_id)
    @key  = UsersNewsletter.unsubscribe_key(@user.email)

    mail(:to => @user.email_address_with_name,
         :subject => "Thank you for Subscribing!")

  end

  def launch_email(user_id)
    @user = User.where(:id => user_id).first
    @key  = UsersNewsletter.unsubscribe_key(@user.email)

    mail(:to => @user.email_address_with_name,
         :subject => "UFC FIT Newsletter")
  end

  def registration_email(user_id)
    @user = User.where(:id => user_id).first
    @key  = UsersNewsletter.unsubscribe_key(@user.email)

    mail(:to => @user.email_address_with_name,
         :subject => "Thank you for Registering!")
  end
end
