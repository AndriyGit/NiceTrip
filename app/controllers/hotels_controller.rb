class HotelsController < BaseObjectsController

  def create_object
    @object = Hotel.new(permited_params)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def permited_params
    params.require(:hotel).permit(:name, :address, :rating)
  end

end
