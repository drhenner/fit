class PrivacyPoliciesController < ApplicationController
  skip_before_filter :redirect_to_welcome
  def show
    render :layout => false
  end

  private

end
