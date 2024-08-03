Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]

  root 'pages#dashboard'
  resources :employees
  resources :departments, only: [:index, :show] do
    resources :teams, only: [:show]
  end
  
  resources :allowances
  resources :payslip_allowances, only: [:destroy]
  resources :deductions
  resources :payslip_deductions, only: [:destroy]
  resources :payslips do
    member do
      get 'dowload'
      get 'preview'
      post 'increase_present_days'
      post 'decrease_present_days'
      post 'increase_absent_days'
      post 'decrease_absent_days'
    end
  end
  get 'payslips/pdf/:id', to: 'payslips#generate_payslip', as: 'generate_payslip'
  resources :teams, only: [:index, :new, :create]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

end