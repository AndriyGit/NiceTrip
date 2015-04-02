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
      redirect_to new_base_object_path(type: 'hotel'), notice: "#{@object._type} was successfully created."
    else
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
    city = Geocoder.search(params[:city])
    circle = params[:circle] || 10
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