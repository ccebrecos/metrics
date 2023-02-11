Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :v1, defaults: { format: :json } do
    resources :metrics, only: [:index]
  end
end
