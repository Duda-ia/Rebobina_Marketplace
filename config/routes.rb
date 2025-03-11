Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :orders
  resources :products do
    resources :orders, only: [:new, :create]
  end

  # resources :users do
  #   resources :orders, only: [:index]
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "seller_products", to: "products#seller_products"
  get "buyer_products", to: "orders#buyer_products"

  # get "categories", to: "products#categories"
  # Defines the root path route ("/")
  # root "posts#index"
end
