class PreordersController < ApplicationController
  helper_method :upsells
  before_filter :redirect_unless_preorder
  layout 'preorder'

  def index
    @products = Product.preorders
    if session_cart.media_cart_items.empty?
      redirect_to root_url
    end
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
      @upsells ||= Variant.includes([:product,{:image_group => :images}]).upsells.limit(3).all
    end

end
