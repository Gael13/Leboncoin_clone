# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.delete_all
product = Product.create!(title: 'Product 1',
	            description: 'description product 1',
	            price: 10.90)
product.image.attach(io: File.open(Rails.root.join('app/assets/images/product.png')),
                  filename: 'product.png')

Cart.delete_all
Cart.create!