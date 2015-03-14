class Hotel < BaseObject
  include Mongoid::Document
  field :min_price, type: Integer
  field :number_of_stars, type: Integer

end
