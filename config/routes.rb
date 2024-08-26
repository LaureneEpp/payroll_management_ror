Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'profile', to: 'users#show', as: 'profile'

  get 'search', to: 'search#index', as: 'search'

  root 'pages#dashboard'
  resources :employees
  resources :departments, only: [:index, :show] do
    resources :teams, only: [:show]
  end
  resources :teams, except: [:show]
end