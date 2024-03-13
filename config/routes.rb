Rails.application.routes.draw do
  resources :esdas, constraints: ->(req) { req.format == :json }
  resources :items do
    member do
      post :publish
    end
  end
  root "home#index"
end
