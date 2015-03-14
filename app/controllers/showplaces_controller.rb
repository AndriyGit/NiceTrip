class ShowplacesController < BaseObjectsController

  def create_object
    @object = Showplace.new(permitted_params)
  end

  private

  def permitted_params
    params.require(:showplace).permit(common_permitted_params + [:kind])
  end
end
