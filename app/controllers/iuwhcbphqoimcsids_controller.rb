class IuwhcbphqoimcsidsController < ApplicationController
  skip_before_filter :redirect_to_welcome
  helper_method :number_of_orders, :number_of_customers, :number_of_users
  def show
    @number_of_users
    render :layout => 'blank'
  end
  private

  def number_of_orders
    @number_of_orders ||= Order.finished.count
  end

  def number_of_customers
    @number_of_customers ||= Order.finished.group(:user_id).count.size
  end

  def number_of_users
    @number_of_users ||= User.count
  end
end
