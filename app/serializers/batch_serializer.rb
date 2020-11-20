class BatchSerializer
  include JSONAPI::Serializer
  attributes :reference, :purchase_channel

  has_many :orders
end
