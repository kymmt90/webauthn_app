Rails.application.routes.draw do
  resource :session, only: [:destroy]

  resources :credentials, only: [:index]
  resources :users, only: [:new, :create]

  namespace :webauthn do
    resources :credential_creation_options, only: [:index]
  end
end
