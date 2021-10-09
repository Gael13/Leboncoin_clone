# Leboncoin_clone

# Init project
docker-compose up

docker-compose run web rails db:create

docker-compose run web rails db:migrate

docker-compose run web rails db:seed

# Launch tests
docker-compose run web bundle exec rails test

# Add product to cart and import products

The prototype is focused on 2 features: - as an user I can add a product to the cart and remove it

- as an owner, I can add or import products, to import products go to /products and upload with tmp/products.csv
