class MainSalesController < ApplicationController

  def update
    @variant = Variant.find(params[:variant_id])
    session_cart.change_main_sale(@variant, most_likely_user)
    redirect_to preorders_url(:anchor => 'your-cart-items')
  end

end
