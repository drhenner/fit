class WelcomeController < ApplicationController
  skip_before_filter :redirect_to_welcome
  layout 'application'

  def index
    @user = User.new
    if current_user && current_user.admin?
    else
      render :template => 'welcome/signup', :layout => 'welcome' if Settings.in_signup_period
    end
  end
end
