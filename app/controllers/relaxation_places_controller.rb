class RelaxationPlacesController < BaseObjectsController

  def create_object
    @object = RelaxationPlace.new(permitted_params)
  end


  private

  def permitted_params
    params.require(:relaxation_place).permit(common_permitted_params + [:kind])
  end

end
