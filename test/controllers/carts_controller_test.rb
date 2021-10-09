require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @cart = Cart.create
    @product = Product.create!(title: 'Product 1',
              description: 'description product 1',
              price: 10.90)


    #@product.image.attach(io: File.open(Rails.root.join('app/assets/images/product.png')),
                  #filename: 'product.png')




    puts "PRODUCT ======> #{@product.image}"
    #@product.save!

    @product_cart = ProductCart.create(cart: @cart, product: @product)
  end


  def test_should_get_cart
  	get cart_path(@cart.id)
  	assert_response :success
  end

  def test_add_product_to_cart
  	#ProductCart.delete_all

  	#post create_product_cart_path(product_id: @product.id)

  	#puts "ProductCart ====> #{ProductCart.all}"

  	#assert_equal 1, ProductCart.count


    assert_difference('ProductCart.count') do
       post create_product_cart_path(product_id: @product.id)
    end

    assert_redirected_to cart_path(@cart.id)
  end

  # test "should create product" do
  #   assert_difference('Product.count') do
  #     post products_url, params: { product: { description: @product.description, image: @product.image, price: @product.price, title: @product.title } }
  #   end

  #   assert_redirected_to product_url(Product.last)
  # end

  def test_remove_product_to_cart

  # 	delete destroy_product_cart_path(id: product_cart.id)

  # 	puts "ProductCart ====> #{ProductCart.all}"

  # 	assert_equal 0, ProductCart.size
  #product_cart = ProductCart.last

    assert_difference('ProductCart.count', -1) do
       delete destroy_product_cart_path(id: @product_cart.id)
    end
  end

  # test "should destroy product" do
  #   assert_difference('Product.count', -1) do
  #     delete product_url(@product)
  #   end

  #   assert_redirected_to products_url
  # end

end