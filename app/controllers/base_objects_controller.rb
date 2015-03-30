class BaseObjectsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :find_address]
  before_action :find_object, only: [:show, :edit, :update, :destroy, :find_address]
  before_action :set_text_fields_to_render, only: :show

  def index
    @objects = BaseObject.all
  end

  def new
    @object = constantized_object_type.new
  end

  def edit
  end

  def create
    create_object
    @object.user = current_user

    if @object.save
      redirect_to base_objects_path #, notice: '#{@object.type} was successfully created.'
    else
      # render :new, locals: { type: @type }
      redirect_to :back, notice: "You didn't fill all required fields. Please try again."
    end
  end

  def show
  end

  def common_permitted_params
    [:name, :rating, :latitude, :longitude, :image]
  end

  def find_address
    render json: {address: @object.find_address}
  end

  def search
    
  end

  private

  def find_object
    @object = BaseObject.find(params[:id])
  end

  def set_text_fields_to_render
    all_fields = @object.attributes.keys
    @text_fields_to_render = @object.attributes.keys - BaseObject::FIELDS_DO_NOT_RENDER
  end

  def constantized_object_type
    @type = params[:type]
    @type.classify.constantize
  end

end