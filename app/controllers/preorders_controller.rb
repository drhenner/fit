class PreordersController < ApplicationController
  skip_before_filter :redirect_to_welcome
  before_filter :redirect_unless_preorder

  def index
    @products = Product.preorders.all
  end

  def show
    @product = Product.preorders.find(params[:id])
  end

  private


end
