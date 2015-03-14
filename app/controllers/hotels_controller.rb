class HotelsController < BaseObjectsController

  def create_object
    @object = Hotel.new(permitted_params)
  end


  private

  def permitted_params
    params.require(:hotel).permit(common_permitted_params +  [:min_price, :number_of_stars])
  end

end
