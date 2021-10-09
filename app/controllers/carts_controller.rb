class CartsController < ApplicationController
  before_action :set_cart, only: [:cart, :create_product_cart, :destroy_product_cart]

  def cart
  end

  def create_product_cart
    product = Product.find(params[:product_id])
    @product_cart = @cart.add_product(product)

    respond_to do |format|
      if @product_cart.save
        format.html { redirect_to @cart }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @product_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_product_cart
    @product_cart = ProductCart.find(params[:id])
    @product_cart.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to @cart }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_cart_params
    params.require(:product_cart).permit(:product_id)
  end

  def set_cart
     @cart = Cart.first
   end
end
