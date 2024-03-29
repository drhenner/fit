class Shopping::BaseController < ApplicationController
  helper_method :session_order, :session_order_id, :selected_checkout_tab
  skip_before_filter :redirect_to_welcome
  before_filter :redirect_unless_preorder
  # these are methods that can be used for all orders

  protected

  def ssl_required?
    ssl_supported?
  end

  private


  def ensure_in_united_states
    if !current_user
      session[:return_to] = shopping_orders_url
      redirect_to login_url
    elsif current_user.country_id != Country::USA_ID
      flash[:alert] = 'Sorry, UFCFIT is only processing orders for customers in the United States.'
      redirect_to preorders_url
    end
  end

  def display_preorder_button?
    false
  end

  def selected_checkout_tab(tab)
    tab == ''
  end

  def next_form_url(order)
    next_form(order) || shopping_orders_url
  end

  def next_form(order)

    # if cart is empty
    if session_cart.shopping_cart_items.empty?
      flash[:notice] = I18n.t('do_not_have_anything_in_your_cart')
      return products_url
    ## If we are insecure
    elsif not_secure?
      session[:return_to] = shopping_orders_url
      return login_url()
    elsif session_order.ship_address_id.nil?
      return shopping_addresses_url()
    elsif !session_order.all_order_items_have_a_shipping_rate?
      return shopping_shipping_methods_url()
    elsif session_order.bill_address_id.nil?
      return shopping_billing_addresses_url()
    elsif session_order.payment_profile_id.nil?
      return shopping_payments_url
    end
  end

  def not_secure?
    !current_user || has_not_logged_in_recently? #|| user_visited_a_non_ssl_page_since_login?
  end

  def has_not_logged_in_recently?(minutes = 45)
    session[:authenticated_at].nil? || Time.now - session[:authenticated_at] > (60 * minutes)
  end

  ## this should happen every time the user goes to a non-SSL page
  def user_visited_a_non_ssl_page_since_login?
    false
    # cookies[:insecure].nil? || cookies[:insecure] == true
  end

  def session_order
    find_or_create_order
  end

  def session_order_id
    session[:order_id] ? session[:order_id] : find_or_create_order.id
  end

  def find_or_create_order
    return @session_order if @session_order
    if session[:order_id]
      @session_order = current_user.orders.include_checkout_objects.find_by_id(session[:order_id])
      create_order if !@session_order || !@session_order.in_progress?
    else
      create_order
    end
    @session_order
  end

  def create_order
    @session_order = current_user.orders.create(:number       => Time.now.to_i,
                                                :ip_address   => request.env['REMOTE_ADDR']  )
    add_new_cart_items(session_cart.shopping_cart_items)
    session[:order_id] = @session_order.id
  end

  def add_new_cart_items(items)
    items.each do |item|
      @session_order.add_items(item.variant, item.quantity)
    end
  end
end
