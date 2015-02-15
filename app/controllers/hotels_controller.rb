class HotelsController < ApplicationController

  def index
    @hotels = Hotel.all
  end

  def show
  end

  def new
    @hotel = Hotel.new
  end

  def edit
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to hotels_path, notice: 'Hotel was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end





  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :address, :rating)
    end

end
