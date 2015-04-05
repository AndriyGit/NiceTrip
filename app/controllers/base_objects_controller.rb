class BaseObjectsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :find_address]
  before_action :find_object, only: [:show, :edit, :update, :destroy, :find_address]
  before_filter :is_user_owner?, only: [:edit, :destroy]
  before_action :set_text_fields_to_render, only: :show

  SOME_FIELD_IS_EMPTY_MESSAGE = "You didn't fill all required fields or filled some of them incorrect. Please try again."

  def index
    @objects = BaseObject.all
  end

  def show
  end

  def new
    @object = constantized_object_type.new
  end

  def create
    create_object
    @object.user = current_user

    if @object.save
      redirect_to @object, notice: "#{@object._type} was successfully created."
    else
      redirect_to :back, notice: SOME_FIELD_IS_EMPTY_MESSAGE
    end
  end

  def edit
    @type = @object._type.underscore
    render :new
  end

  def update
    if @object.update(permitted_params)
      redirect_to @object, notice: "#{@object.name} was successfully updated."
    else
      redirect_to :back, notice: SOME_FIELD_IS_EMPTY_MESSAGE
    end
  end

  def destroy
    if @object.destroy
      redirect_to root_path, notice: "#{@object.name} was successfully deleted."
    else
      redirect_to @object
    end
  end

  def common_permitted_params
    [:name, :rating, :latitude, :longitude, :image]
  end

  def find_address
    render json: {address: @object.find_address}
  end

  def search
    city = Geocoder.search(params[:city])
    circle = params[:radius].to_i
    if city.any?
      lat, lng = city.first.data["geometry"]["location"]["lat"], city.first.data["geometry"]["location"]["lng"]
      objects = BaseObject.all.inject({}) do |result, object|
        if Geocoder::Calculations.distance_between([lat, lng], [object.latitude, object.longitude]) < circle
          result[object.id] = {
            name: object.name,
            image: object.image.url(:for_map),
            image_big: object.image.url(:thumb),
            type: object._type,
            lat: object.latitude,
            lng: object.longitude
          }
        end
        result
      end
      if objects.any?
        render json: objects, status: :ok
      else
        render json: { error: "#{t('no_place_found_for')} #{params[:city]}", lat: lat, lng: lng }, status: :bad_request
      end and return
    end
    render json: {error: "#{t('no_result_for')} #{params[:city]}"}, status: :bad_request
  end

  private

  def find_object
    @object = begin
      BaseObject.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      render_404_page
    end
  end

  def set_text_fields_to_render
    all_fields = @object.attributes.keys
    @text_fields_to_render = @object.attributes.keys - BaseObject::FIELDS_DO_NOT_RENDER
  end

  def constantized_object_type
    @type = params[:type]
    @type.classify.constantize
  end

  def is_user_owner?
    redirect_to @object if @object.user != current_user
  end

end