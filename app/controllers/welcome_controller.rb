class WelcomeController < ApplicationController
  skip_before_filter :redirect_to_welcome
  layout 'welcome'

  def index
    @user = User.new
  end
end
