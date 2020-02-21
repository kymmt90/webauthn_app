class UsersController < ApplicationController
  skip_before_action :redirect_not_logged_in_user_to_new_user_path, only: [:new, :create]

  def new
    if logged_in?
      redirect_to credentials_path
    end
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
      render :new, formats: :html
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, public_key_credential: {})
  end
end
