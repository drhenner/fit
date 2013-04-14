class UserOauthController < ApplicationController

  def create
    @user = User.from_omniauth!(auth_hash)
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "UFCFit") if is_navigational_format?
      sign_in_and_redirect(@user, event: :authentication)
    else
      redirect_to root_url
    end
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
