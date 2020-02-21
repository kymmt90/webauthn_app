class SessionsController < ApplicationController
  skip_before_action :redirect_not_logged_in_user_to_new_user_path, only: [:new, :create]

  def new
  end

  def create
    user = User.joins(:webauthn_setting).find_by!(uid: session_params[:uid])

    if user.authenticate(session_params[:public_key_credential], session[:webauthn_request_challenge])
      reset_session
      session[:current_user_id] = user.id

      head :no_content
    else
      render :new, formats: :html
    end
  end

  def destroy
    @current_user = nil
    reset_session

    redirect_to new_user_path
  end

  private

  def session_params
    params.require(:session).permit(:uid, public_key_credential: {})
  end
end
