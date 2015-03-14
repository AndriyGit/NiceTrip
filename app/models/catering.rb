class Catering < BaseObject
  include Mongoid::Document

  field :kind, type: String
  field :expensiveness, type: String

  module KINDS
    RESTAURANT = 'restaurant'
    CAFE = 'cafe'
    BAR = 'bar'
    ALL = [RESTAURANT, CAFE, BAR]
  end

  module EXPENSIVENESS
    CHEAP = 'cheap'
    MIDDLE_PRICE = 'middle_price'
    EXPENSIVE = 'expensive'
    ALL = [CHEAP, MIDDLE_PRICE, EXPENSIVE]
  end

  validates_inclusion_of :kind, in: KINDS::ALL
  validates_inclusion_of :expensiveness, in: EXPENSIVENESS::ALL

end
