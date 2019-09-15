Rails.application.routes.draw do

  #Manual endpoints
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :users
end
