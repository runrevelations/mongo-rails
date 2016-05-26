class Item
  include Mongoid::Document
  validates_presence_of :name, :price
  field :name, type: String
  field :price, type: Float
end
