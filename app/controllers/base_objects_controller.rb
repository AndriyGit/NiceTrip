class BaseObjectsController < ApplicationController

  def index
    @objects = BaseObject.all
  end

  def new
    @object = constantized_object_type.new
    render :partial => "#{object_type.pluralize}/new"
  end

  def create
    create_object
    @object.user = current_user

    respond_to do |format|
      if @object.save
        format.html { redirect_to base_objects_path, notice: '#{@object.type} was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def object_type
    params[:type]
  end

  def constantized_object_type
    object_type.capitalize.constantize
  end

end