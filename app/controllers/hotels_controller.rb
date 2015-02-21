class HotelsController < BaseObjectsController


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def permited_params
    params.require(:hotel).permit(:name, :address, :rating)
  end

end
