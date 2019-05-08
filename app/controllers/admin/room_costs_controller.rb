class Admin::RoomCostsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @room_costs = RoomCost.all.page params[:page]
  end

  def create
    cost_service = CostCaculateService.new
    if @room_cost.valid?
      electric_cost = cost_service.electric_cost @room_cost.get_current_consumption(@room_cost.month)
      @room_cost.update_attributes electric_cost: electric_cost
      @room_cost.save
      update_cost_id @room_cost
      cost_service.auto_create_user_cost @room_cost

      flash[:success] = t ".create_success"
      redirect_to admin_room_costs_url
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
    if @room_cost.update_attributes room_cost_params
      electric_cost = cost_service.electric_cost @room_cost.get_current_consumption(@room_cost.month)
      @room_cost.update_attributes electric_cost: electric_cost
      update_cost_id @room_cost
      cost_service.auto_create_user_cost @room_cost

      flash[:success] = t ".update_success"

      redirect_to admin_room_costs_url
    else
      render :edit
    end
  end

  private
  def room_cost_params
    params.require(:room_cost).permit(RoomCost::ATTRIBUTE_PARAMS)
  end

  def update_cost_id room_cost
    cost = Cost.get_by_month room_cost.month
    if cost.present?
      room_cost.update cost_id: cost[0] ? cost[0].id : cost.id
    end
  end
end
