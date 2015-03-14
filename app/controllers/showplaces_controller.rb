class ShowplacesController < BaseObjectsController

  def create_object
    @object = Showplace.new(permited_params)
  end

  private

  def permited_params
    params.require(:showplace).permit(:name, :kind, :address, :rating, :image, :latitude, :longitude)
  end
end
