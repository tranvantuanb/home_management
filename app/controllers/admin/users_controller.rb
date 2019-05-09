class Admin::UsersController < ApplicationController
  load_and_authorize_resource :find_by => :slug
  layout "admin"

  def index
    @users = User.all.page params[:page]
    @user_costs = UserCost.all.page params[:page]
  end

  def create
    if @user.valid?
      @user.save
      flash[:success] = t ".create_success"
      redirect_to admin_users_url
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    update_params = user_params
    if params.require(:user)[:password].blank? && params.require(:user)[:password_confirmation].blank?
      update_params.except!(:password, :password_confirmation)
    end
    
    if @user.update_attributes update_params
      flash[:success] = t ".update_success"

      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def get_user_cost_info
    month = params[:month].present? ? Date.parse(params[:month]) : ""
    @user_costs = UserCost.filter_by_month month
    @user_costs = @user_costs.page params[:page]
    render partial: 'user_cost'
  end

  private
  def user_params
    params.require(:user).permit(User::ATTRIBUTE_PARAMS)
  end
end
