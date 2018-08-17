class UsersController < ApplicationController
  def show
    @user = User.friendly.find params[:id]
    @user_costs = @user.user_costs.page params[:page]
  end
end
