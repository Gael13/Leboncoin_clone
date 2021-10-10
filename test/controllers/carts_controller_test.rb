require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @cart = Cart.create
    @product = Product.create!(title: 'Product 1',
              description: 'description product 1',
              price: 10.90)

    @product_cart = ProductCart.create(cart: @cart, product: @product)
  end


  def test_should_get_cart
  	get cart_path(@cart.id)
  	assert_response :success
  end

  def test_add_product_to_cart
    assert_difference('ProductCart.count') do
       post create_product_cart_path(product_id: @product.id)
    end

    assert_redirected_to cart_path(@cart.id)
  end

  def test_remove_product_to_cart
    assert_difference('ProductCart.count', -1) do
       delete destroy_product_cart_path(id: @product_cart.id)
    end
  end

end