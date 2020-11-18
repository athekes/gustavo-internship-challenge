class Order < ApplicationRecord
  belongs_to :batch
  serialize :line_items, Array
  monetize :total_value_cents
  enum status: %i[ready production closing sent]
end
