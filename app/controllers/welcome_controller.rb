class WelcomeController < ApplicationController
  skip_before_filter :redirect_to_welcome
  layout 'application'

  def index
    @user = User.new
    if Settings.in_signup_period
      if current_user && current_user.admin?
        render  :layout => 'preorder'
      else
        render :template => 'welcome/signup', :layout => 'welcome'
      end
    elsif
      render  :layout => 'preorder'
    end
  end

  def load
    render :text => 'loaderio-79aeb8198cf6b8d1faffd0edad063326', :layout => false
  end
end
