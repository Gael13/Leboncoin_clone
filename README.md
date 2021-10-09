# Leboncoin_clone

# Init project
docker-compose up

docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails db:seed

# Launch tests
docker-compose run web bundle exec rails test

# Import products
go to /products and upload with tmp/products.csv
