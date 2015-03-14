class RelaxationsController < BaseObjectsController

  def create_object
    @object = Relaxation.new(permited_params)
  end


  private

  def permited_params
    params.require(:relaxation).permit(:name, :kind, :address, :rating, :image, :latitude, :longitude)
  end

end
