class BaseObject
  include Mongoid::Document

  mount_uploader :image, ImageUploader
  field :name, type: String
  field :rating, type: Integer
  field :latitude, type: String
  field :longitude, type: String
  field :published, type: Boolean, default: false

  belongs_to :user

  SHOW_ALL = 'show_all'
  CATERING = 'catering'
  HOTEL = 'hotel'
  RELAXATION_PLACE = 'relaxation_place'
  SHOWPLACE = 'showplace'
  ALL = [CATERING, HOTEL, RELAXATION_PLACE, SHOWPLACE]

  FIELDS_DO_NOT_RENDER = ['_id', '_type', 'latitude', 'longitude', 'published', 'user_id', 'image']

  validates_presence_of :name, :rating, :latitude, :longitude
  validates :rating, numericality: true, inclusion: { in: 1..10 }

  def find_address
    address = Geocoder.search("#{latitude}, #{longitude}")
    if address.any?
      address.first.data["formatted_address"]
    else
      ''
    end
  end

end
