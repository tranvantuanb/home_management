class Admin::RoomsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @rooms = Room.all.page params[:page]
  end

  def create
    if @room.valid?
      @room.save
      flash[:success] = t ".create_success"
      redirect_to admin_rooms_url
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
    if @room.update_attributes room_params
      flash[:success] = t ".update_success"

      redirect_to admin_rooms_url
    else
      render :edit
    end
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end
