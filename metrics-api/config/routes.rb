Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :metrics, only: [:index, :create]
  end
end
