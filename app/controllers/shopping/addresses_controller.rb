class Shopping::AddressesController < Shopping::BaseController
  helper_method :countries, :phone_types
  before_filter :ensure_in_united_states
  # GET /shopping/addresses
  def index
    if session_cart.shopping_cart_items.empty?
      flash[:notice] = I18n.t('do_not_have_anything_in_your_cart')
      redirect_to products_url and return
    end
    @form_address = @shopping_address = Address.new
    @form_address.phones.build
    if !Settings.require_state_in_address && countries.size == 1
      @shopping_address.country = countries.first
    end
    form_info
  end

  # GET /shopping/addresses/1/edit
  def edit
    form_info
    @form_address = @shopping_address = Address.find(params[:id])
    @form_address.phones.build if @form_address.phones.empty?
  end

  # POST /shopping/addresses
  def create
    if params[:address].present?
      @shopping_address = current_user.addresses.new(params[:address])
      @shopping_address.default = true          if current_user.default_shipping_address.nil?
      @shopping_address.billing_default = true  if current_user.default_billing_address.nil?
      @shopping_address.save
      @form_address = @shopping_address
    elsif params[:shopping_address_id].present?
      @shopping_address = current_user.addresses.find(params[:shopping_address_id])
    end

      if @shopping_address.id
        update_order_address_id(@shopping_address.id)
        redirect_to(shopping_shipping_methods_url)
      else
        form_info
        render :action => "index"
      end
  end

  def update
    args = params[:address].clone
    args[:phones_attributes].each_pair{|i,p| p.delete('id')} if args[:phones_attributes].present?
    @shopping_address = current_user.addresses.new(args)
    @shopping_address.replace_address_id = params[:id] # This makes the address we are updating inactive if we save successfully

    # if we are editing the current default address then this is the default address
    @shopping_address.default         = true if params[:id].to_i == current_user.default_shipping_address.try(:id)
    @shopping_address.billing_default = true if params[:id].to_i == current_user.default_billing_address.try(:id)

      if @shopping_address.save
        update_order_address_id(@shopping_address.id)
        redirect_to(shopping_shipping_methods_url)
      else
        # the form needs to have an id
        @form_address = current_user.addresses.find(params[:id])
        # the form needs to reflect the attributes to customer entered
        params[:address].delete('phones_attributes')
        @form_address.attributes = params[:address]
        @form_address.phones.build if @form_address.phones.empty?
        @states     = State.form_selector
        render :action => "edit"
      end
  end

  def select_address
    address = current_user.addresses.find(params[:id])
    update_order_address_id(address.id)
    redirect_to shopping_shipping_methods_url
  end

  def destroy
    @shopping_address = Address.find(params[:id])
    @shopping_address.update_attributes(:active => false)

    redirect_to(shopping_addresses_url)
  end

  private

  def selected_checkout_tab(tab)
    tab == 'shipping-address'
  end

  def phone_types
    @phone_types ||= PhoneType.all.map{|p| [p.name, p.id]}
  end

  def form_info
    @shopping_addresses = current_user.shipping_addresses
    @states     = State.form_selector
  end

  def update_order_address_id(id)
    session_order.update_attributes(
                          :ship_address_id => id ,
                          :bill_address_id => (use_as_billing? ? id : session_order.bill_address_id )
                                    )
  end

  def use_as_billing?
    params[:use_as_billing].present? && params[:use_as_billing] == '1'
  end

  def countries
    @countries ||= Country.active
  end

end
