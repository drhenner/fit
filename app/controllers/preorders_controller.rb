class PreordersController < ApplicationController
  helper_method :upsells
  skip_before_filter :redirect_to_welcome
  before_filter :redirect_unless_preorder
  layout 'preorder'

  def index
    @products = Product.preorders.all
  end

  def show
    @product = Product.preorders.find(params[:id])
  end

  private
    def upsells
      @upsells ||= Variant.upsells.limit(4).all
    end

end
