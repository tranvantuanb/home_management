class Admin::FloorsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @floors = Floor.all.page params[:page]
  end

  def create
    if @floor.valid?
      @floor.save
      flash[:success] = t ".create_success"
      redirect_to admin_floors_url
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
    if @floor.update_attributes floor_params
      flash[:success] = t ".update_success"

      redirect_to admin_floors_url
    else
      render :edit
    end
  end

  private
  def floor_params
    params.require(:floor).permit(:name)
  end
end
