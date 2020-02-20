class ApplicationController < ActionController::Base
  before_action :redirect_not_logged_in_user_to_new_user_path

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  private

  def redirect_not_logged_in_user_to_new_user_path
    return if current_user

    redirect_to new_user_path
  end
end
