class HotelsController < BaseObjectsController

  def create_object
    @object = Hotel.new(permited_params)
  end

  private

  def permited_params
    params.require(:hotel).permit(:name, :address, :rating, :image)
  end

end
