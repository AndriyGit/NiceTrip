class Relaxation < BaseObject
  include Mongoid::Document

  field :kind, type: String

  module KINDS
    ZOO = 'zoo'
    WATER_PARK = 'water_park'
    CLUB = 'club'
    BEACH = 'beach'
    THEATER = 'theater'
    CINEMA = 'cinema'
    ALL = [ZOO, WATER_PARK, CLUB, BEACH, THEATER, CINEMA]
  end

  validates_inclusion_of :kind, in: KINDS::ALL

end
