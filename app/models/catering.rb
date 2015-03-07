class Catering < BaseObject
  include Mongoid::Document

  field :kind, type: String

end
