class Catering < BaseObject
  include Mongoid::Document

  field :kind, type: String
  field :expensiveness, type: String

end
