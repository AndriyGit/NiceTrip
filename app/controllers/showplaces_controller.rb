class ShowplacesController < BaseObjectsController

  def create_object
    @object = Showplace.new(permited_params)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def permited_params
    params.require(:showplace).permit(:name, :kind, :rating)
  end
end
