Rails.application.routes.draw do
  root 'users#new'

  resource :session, only: [:new, :create, :destroy]

  resources :credentials, only: [:index]
  resources :users, only: [:new, :create]

  namespace :webauthn do
    resources :credential_creation_options, only: [:index]
    resources :credential_request_options, only: [:index]
  end
end
