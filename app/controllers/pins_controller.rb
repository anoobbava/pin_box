class PinsController < ApplicationController
  before_action :find_pin, only:[:destroy, :edit, :update, :show ]
  before_action :authenticate_user!, only:[:new, :destroy, :edit]

  def index
    @pins = Pin.all.order('created_at DESC')
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user = current_user
    if @pin.save
      redirect_to @pin, notice: 'successfully Created Pin'
    else
      render 'new'
    end
  end

  def destroy
    if @pin.user == current_user
      if @pin.destroy
        redirect_to pins_path, notice: 'successfully Deleted the Pin'
      else
        redirect_to @pin, notice: 'Error in Deleting the Pin'
      end
    else
      redirect_to @pin, notice: 'You cant delete others Pin'
    end
  end

  def edit
    if @pin.user == current_user
      render 'edit'
    else
      render 'edit', notice: 'You cant edit others Pins'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice:  'successfully Updated Pin'
    else
      render 'edit'
    end
  end

  private

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end
end
