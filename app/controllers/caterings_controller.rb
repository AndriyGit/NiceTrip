class CateringsController < BaseObjectsController

  def create_object
    @object = Catering.new(permitted_params)
  end


  private

  def permitted_params
    params.require(:catering).permit(common_permitted_params + [:kind, :expensiveness])
  end

end
