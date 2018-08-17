class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path
    flash[:danger] = t "devise.failure.unauthenticated"
  end
  protect_from_forgery with: :exception
end
