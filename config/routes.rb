Rails.application.routes.draw do
  root 'passengers/home#index'

  devise_for :admins

  namespace :admins do
    root to: 'home#index'

    resources :flights
    resources :flight_classes, only: %i[edit update]

    resources :aeroplanes do
      resources :aeroplane_classes
    end
  end

  namespace :passengers do
    resource :flight_reservation, only: %i[edit update]
    resources :flight_reservations, only: %i[create]
  end
end
