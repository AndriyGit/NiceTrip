class Hotel < BaseObject
  include Mongoid::Document
    field :min_price, type: Integer

    belongs_to :user
end
