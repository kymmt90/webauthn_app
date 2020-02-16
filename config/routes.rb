Rails.application.routes.draw do
  namespace :webauthn do
    resources :credential_creation_options, only: [:index]
  end
end
