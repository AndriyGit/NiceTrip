class BaseObjectsController < ApplicationController

  before_filter :authenticate_user!, except: :index

  def index
    @objects = BaseObject.all
  end

  def new
    @object = constantized_object_type.new
  end

  def create
    create_object
    @object.user = current_user

    respond_to do |format|
      if @object.save
        format.html { redirect_to base_objects_path, notice: '#{@object.type} was successfully created.' }
      else
        format.html { render :partial => 'form' }
      end
    end
  end

  def common_permitted_params
    [:name, :address, :rating, :latitude, :longitude, :image]
  end


  private

  def constantized_object_type
    @type = params[:type]
    @type.classify.constantize
  end

end