class Cart < ApplicationRecord
  has_many :product_carts, dependent: :destroy
  

  def add_product(product)
  	current_product = product_carts.build(product_id: product.id)
  	current_product
  end

end
