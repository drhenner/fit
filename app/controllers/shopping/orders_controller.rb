class Shopping::OrdersController < Shopping::BaseController
  before_filter :require_login

  layout 'checkout'
  # GET /shopping/orders
  ### The intent of this action is two fold
  #
  # A)  if there is a current order redirect to the process that
  # => needs to be completed to finish the order process.
  # B)  if the order is ready to be checked out...  give the order summary page.
  #
  ##### THIS METHOD IS BASICALLY A CHECKOUT ENGINE
  def index
    @order = find_or_create_order
    if f = next_form(@order)
      redirect_to f
    else
      form_info
    end
  end
  # method stripe calls to get the order total right before getting the token
  def show
    @order = find_or_create_order
    @order.credited_total
    respond_to do |format|
      format.json  { render :json => @order.to_json(:only => [:number, :integer_credited_total], :methods => [:integer_credited_total]) }
    end
  end


  #  add checkout button
  def checkout
    #current or in-progress otherwise cart (unless cart is empty)
    order = find_or_create_order
    @order = session_cart.add_items_to_checkout(order) # need here because items can also be removed
    redirect_to shopping_orders_url
  end

  # POST /shopping/orders
  def update
    @order = find_or_create_order
    @order.ip_address = request.remote_ip

    if !@order.in_progress?
      session_cart.mark_items_purchased(@order)
      flash[:error] = I18n.t('the_order_purchased')
      redirect_to myaccount_order_url(@order)
    elsif @order.payment_profile
      if response = @order.create_invoice(@credit_card,
                                          @order.credited_total,
                                          @order.payment_profile,
                                          @order.amount_to_credit)
        if response.succeeded?
          ##  MARK items as purchased
          session_cart.mark_items_purchased(@order)
          redirect_to( myaccount_order_path(@order) ) and return
        else
          flash[:alert] =  [I18n.t('could_not_process'), I18n.t('the_order')].join(' ')
        end
      else
        flash[:alert] = [I18n.t('could_not_process'), I18n.t('the_credit_card')].join(' ')
      end
      form_info
      render :action => 'index'
    else
      form_info
      flash[:alert] = [I18n.t('form not filled out correctly')].join(' ')
      render :action => 'index'
    end
  end

  def preorder
    @order = find_or_create_order
    @order.ip_address = request.remote_ip

    if !@order.in_progress?
      session_cart.mark_items_purchased(@order)
      flash[:error] = I18n.t('the_order_purchased')
      redirect_to myaccount_order_url(@order)
    elsif @order.payment_profile
      if response = @order.create_preorder_invoice(
                                          @order.credited_total,
                                          @order.payment_profile,
                                          @order.amount_to_credit)
        if response.preordered?
          ##  MARK items as purchased
          session_cart.mark_items_purchased(@order)
          redirect_to( myaccount_order_path(@order) ) and return
        else
          flash[:alert] =  [I18n.t('could_not_process'), I18n.t('the_order')].join(' ')
        end
      else
        flash[:alert] = [I18n.t('could_not_process'), I18n.t('the_credit_card')].join(' ')
      end
      form_info
      render :action => 'index'
    else
      form_info
      flash[:alert] = [I18n.t('form not filled out correctly')].join(' ')
      render :action => 'index'
    end
  end

  private

  def selected_checkout_tab(tab)
    tab == 'order-details'
  end

  def form_info
    @order.credited_total
  end
  def require_login
    if !current_user
      session[:return_to] = shopping_orders_url
      redirect_to( login_url() ) and return
    end
  end

end
