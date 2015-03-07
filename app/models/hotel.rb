class Hotel < BaseObject
  include Mongoid::Document
  field :min_price, type: Integer
  field :stars, type: Integer

end
