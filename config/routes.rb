Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'movies#index'

  resources :movies, only: [:index, :show] do
    member do
      get 'reservation'
    end
    resources :schedules, only: [:show] do
      resources :reservations, only: [:new, :create]
    end
  end
  namespace :admin do
    resources :movies, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :schedules, only: [:new, :create, :edit, :update, :destroy]
      resources :movie_cinemas, only: [:show, :create, :destroy]
    end
    resources :schedules, only: [:index, :show]
    resources :reservations, only: [:index, :show, :new, :create, :update, :destroy]
  end

  resources :sheets, only: [:index]

  resources :reservations, only: [:new, :create]
  # テスト用ルーティング
end
