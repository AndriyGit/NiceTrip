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
end
