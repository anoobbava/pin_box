class PinsController < ApplicationController
  before_action :find_pin, only:[:destroy, :edit, :update, :show ]

  def index
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'successfully Created Pin'
    else
      render 'new'
    end
  end

  def destroy
    if @pin.destroy
      redirect_to pins_path, notice: 'successfully Deleted the Pin'
    else
      redirect_to @pin, notice: 'Error in Deleting the Pin'
    end
  end

  def edit
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
    params.require(:pin).permit(:title, :description)
  end
end
