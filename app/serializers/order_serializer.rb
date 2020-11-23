class OrderSerializer
  include JSONAPI::Serializer
  attributes :reference, :purchase_channel, :client_name, :address,
             :delivery_service, :line_items, :total_value_cents, :status

  belongs_to :batch
end
