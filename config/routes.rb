Rails.application.routes.draw do
  resources :products
  #resources :product_carts


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'store#index'
  
  get '/cart/:id', to: 'carts#cart', as: 'cart'
  post 'create_product_cart', to: 'carts#create_product_cart'
  delete 'destroy_product_cart', to:'carts#destroy_product_cart'

  post 'import', to: 'products#import'

  #get 'store', to: 'products#store'
end
