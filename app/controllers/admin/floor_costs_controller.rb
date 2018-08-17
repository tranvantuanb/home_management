class Admin::FloorCostsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @floor_costs = FloorCost.all.page params[:page]
  end

  def create
    cost_service = CostCaculateService.new
    if @floor_cost.valid?
      electric_cost = cost_service.electric_cost @floor_cost.get_current_consumption(@floor_cost.month)
      @floor_cost.update_attributes electric_cost: electric_cost
      @floor_cost.save
      update_cost_id @floor_cost
      cost_service.auto_create_user_cost @floor_cost

      flash[:success] = t ".create_success"
      redirect_to admin_floor_costs_url
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
    cost_service = CostCaculateService.new
    if @floor_cost.update_attributes floor_cost_params
      electric_cost = cost_service.electric_cost @floor_cost.get_current_consumption(@floor_cost.month)
      @floor_cost.update_attributes electric_cost: electric_cost
      update_cost_id @floor_cost
      cost_service.auto_create_user_cost @floor_cost

      flash[:success] = t ".update_success"

      redirect_to admin_floor_costs_url
    else
      render :edit
    end
  end

  private
  def floor_cost_params
    params.require(:floor_cost).permit(FloorCost::ATTRIBUTE_PARAMS)
  end

  def update_cost_id floor_cost
    cost = Cost.get_by_month floor_cost.month
    if cost.present?
      floor_cost.update cost_id: cost.id
    end
  end
end
