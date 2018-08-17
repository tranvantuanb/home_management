class RegistrationsController < Devise::RegistrationsController

  private
  def sign_up_params
    params.require(:user).permit(User::ATTRIBUTE_PARAMS)
  end

  def account_update_params
    params.require(:user).permit(User::ATTRIBUTE_PARAMS)
  end
end
