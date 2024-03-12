Rails.application.routes.draw do
  resources :esdas, constraints: ->(req) { req.format == :json }
  resources :items
  root "home#index"
end
