Rails.application.routes.draw do
  resources :mining_types
  root to: 'welcome#index'
  resources :coins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
