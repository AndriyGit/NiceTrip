class RelaxationsController < BaseObjectsController

  def create_object
    @object = Relaxation.new(permitted_params)
  end


  private

  def permitted_params
    params.require(:relaxation).permit(common_permitted_params + [:kind])
  end

end
