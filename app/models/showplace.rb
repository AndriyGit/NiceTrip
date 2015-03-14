class Showplace < BaseObject
  include Mongoid::Document

  field :kind, type: String

  module KINDS
    MONUMENT = 'monument'
    SQUARE = 'square'
    BUILDING = 'building'
    STREET = 'street'
    MUSEUM = 'museum'
    ALL = [MONUMENT, SQUARE, BUILDING, STREET, MUSEUM]
  end

  validates_inclusion_of :kind, in: KINDS::ALL

end
