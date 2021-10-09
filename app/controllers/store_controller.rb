class StoreController < ApplicationController

  def index
    @products = Product.order(:price)
    @cart = Cart.first
  end
  
end
