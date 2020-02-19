Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  namespace :webauthn do
    resources :credential_creation_options, only: [:index]
  end
end
