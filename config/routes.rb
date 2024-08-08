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
  
  resources :allowances
  # resources :payslip_allowances, only: [:destroy]
  resources :deductions
  # resources :payslip_deductions, only: [:destroy]

  resources :payslips do
    member do
      get 'download'
      get 'preview'
      post 'increase_present_days'
      post 'decrease_present_days'
      post 'increase_absent_days'
      post 'decrease_absent_days'
    end
  end
  get 'payslips/pdf/:id', to: 'payslips#generate_payslip', as: 'generate_payslip'
end