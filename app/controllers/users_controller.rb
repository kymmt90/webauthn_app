class UsersController < ApplicationController
  def new
  end

  def create
    @signup = User::Signup.new(
      uid: user_params[:uid],
      public_key_credential: user_params[:public_key_credential],
      challenge: session[:webauthn_creation_challenge]
    )

    if @signup.save
      reset_session
      session[:current_user_id] = @signup.user.id

      render formats: :json, status: :created
    else
      render formats: :json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, public_key_credential: {})
  end
end
