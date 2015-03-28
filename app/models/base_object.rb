class BaseObject
  include Mongoid::Document

  mount_uploader :image, ImageUploader
  field :name, type: String
  field :address, type: String
  field :rating, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :published, type: Boolean, default: false

  belongs_to :user

  CATERING = 'catering'
  HOTEL = 'hotel'
  RELAXATION_PLACE = 'relaxation_place'
  SHOWPLACE = 'showplace'
  ALL = [CATERING, HOTEL, RELAXATION_PLACE, SHOWPLACE]

  FIELDS_DO_NOT_RENDER = ['_id', '_type', 'latitude', 'longitude', 'published', 'user_id', 'image']

  validates_presence_of :name, :rating, :latitude, :longitude

  def find_address
    address = Geocoder.search("#{latitude}, #{longitude}")
    if address.any?
      p address.first.data["formatted_address"]
      address.first.data["formatted_address"]
    else
      ''
    end
  end

end
