module Webauthn
  class CredentialCreationOptionsController < ApplicationController
    def index
      user = User.find_or_initialize_by(uid: params[:uid])

      if user.valid?
        options = user.webauthn_credential_create_options

        session[:webauthn_creation_challenge] = options.challenge

        render json: options
      else
        head status: :not_found
      end
    end
  end
end
