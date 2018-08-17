class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    if user_signed_in?
      redirect_to current_user.admin? ? "/admin" : user_path(current_user)
    else
      flash[:danger] = t ".invalid_email_password"
      redirect_to new_user_session_path
    end
  end
end
