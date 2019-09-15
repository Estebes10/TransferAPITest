Rails.application.routes.draw do

  #Manual endpoints
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  #resources :users

  # endpoints following /api/
  namespace :api do

    # endpoints following /api/v1/
    namespace :v1 do

      # endpoints following /api/v1/users
      resources :users, only: %I[show create]
      post 'deliver_money', to: 'users#deliver_money'

      post 'transfer', to: 'transfers#transfer'
      get 'transactions', to: 'transfers#index'

    end

  end

end
