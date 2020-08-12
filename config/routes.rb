Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      resource :passwords, only: [:edit, :update]
    end
  end
  
  resources :words
  
  resources :folders, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :classifications, only: [:create, :destroy]
end
