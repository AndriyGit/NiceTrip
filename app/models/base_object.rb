class BaseObject
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :rating, type: String
  field :photos, type: Array, default: []

  belongs_to :user

end
