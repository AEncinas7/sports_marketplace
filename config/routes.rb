Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :equipments, except: [:edit, :destroy] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :update]
end
