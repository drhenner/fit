class FaqsController < ApplicationController
  skip_before_filter :redirect_to_welcome
  def index
    render :nothing => true
  end

  private

end
