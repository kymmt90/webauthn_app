module Webauthn
  class CredentialRequestOptionsController < ApplicationController
    skip_before_action :redirect_not_logged_in_user_to_new_user_path, only: [:index]

    def index
      user = User.find_by(uid: params[:uid])

      if user
        options = user.webauthn_credential_request_options

        session[:webauthn_request_challenge] = options.challenge

        render json: options
      else
        head status: :not_found
      end
    end
  end
end
