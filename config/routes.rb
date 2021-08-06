Rails.application.routes.draw do
  resources :plots, only: :index do
    resources :plants, only: :destroy
  end

  resources :gardens, only: :show
end
