class UserOauthController < ApplicationController

  def create
    @current_user  = User.from_omniauth!(auth_hash)
    if current_user
      unless current_user.active?
        flash[:session_alert] =  I18n.t('login_inactive')
        redirect_to login_url and return
      end
      @user_session = UserSession.new(current_user, true)
      if @user_session.save
        cookies[:hadean_uid] = @user_session.record.access_token
        session[:authenticated_at] = Time.now
        cookies[:insecure] = false
        ## if there is a cart make sure the user_id is correct
        set_user_to_cart_items
        flash[:notice] = I18n.t('login_successful')
        if @user_session.record.admin?
          redirect_to admin_users_url and return
        else
          redirect_to root_url and return
        end
      end
    end
    flash[:session_alert] =  I18n.t('login_failure')
    redirect_to login_url
  end

  private

  def set_user_to_cart_items
    if session_cart.user_id != @user_session.record.id
      session_cart.update_attributes(:user_id => @user_session.record.id )
    end
    session_cart.cart_items.each do |item|
      item.update_attributes(:user_id => @user_session.record.id ) if item.user_id != @user_session.record.id
    end
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
