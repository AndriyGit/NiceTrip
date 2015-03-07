class CateringsController < BaseObjectsController

  def create_object
    @object = Catering.new(permited_params)
  end

  private

  def permited_params
    params.require(:catering).permit(:name, :kind, :rating, :image)
  end
end
