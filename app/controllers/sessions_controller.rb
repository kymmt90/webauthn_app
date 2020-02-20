class SessionsController < ApplicationController
  def destroy
    @current_user = nil
    reset_session

    redirect_to new_user_path
  end
end
