class Admin::CostsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @costs = Cost.all.page params[:page]
  end

  def create
    if @cost.valid?
      @cost.save
      update_floor_cost @cost
      flash[:success] = t ".create_success"
      redirect_to admin_costs_url
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
    if @cost.update_attributes cost_params
      update_floor_cost @cost
      flash[:success] = t ".update_success"

      redirect_to admin_costs_url
    else
      render :edit
    end
  end

  private
  def cost_params
    params.require(:cost).permit(Cost::ATTRIBUTE_PARAMS)
  end

  def update_floor_cost cost
    floor_costs = FloorCost.get_by_month cost.month
      if floor_costs.present?
        floor_costs.each do |fcost|
          fcost.update cost_id: cost.id
        end
      end
  end
end
