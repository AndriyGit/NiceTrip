class Showplace < BaseObject
  include Mongoid::Document

  field :kind, type: String

end
