class PreordersController < ApplicationController
  helper_method :upsells
  skip_before_filter :redirect_to_welcome
  before_filter :redirect_unless_preorder
  layout 'preorder'

  def index
    @products = Product.preorders
    if session_cart.shopping_cart_items.empty?
      redirect_to root_url
    end
    fresh_when :last_modified => session_cart.updated_at.utc, :etag => [session_cart, @upsells]
  end

  def show
    #@product = Product.preorders.find(params[:id])
    redirect_to preorders_url
  end

  # this adds the default preorder to the cart
  def create
    session_cart.add_default_presale_sale(most_likely_user)
    redirect_to preorders_url
  end

  private
    def upsells
      @upsells ||= Variant.upsells.limit(4).all
    end

end
