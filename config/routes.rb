Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :service_types
  resources :parcels
  resources :addresses
  resources :reports, only: [:index, :show]
  root to: 'parcels#index'
  get '/search', to: 'search#index'

end
