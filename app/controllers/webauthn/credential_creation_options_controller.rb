module Webauthn
  class CredentialCreationOptionsController < ApplicationController
    skip_before_action :redirect_not_logged_in_user_to_new_user_path, only: [:index]

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
