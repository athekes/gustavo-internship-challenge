class Order < ApplicationRecord
  belongs_to :batch, optional: true

  validates :reference, presence: true, uniqueness: { case_sensitive: false }
  validates :purchase_channel, :client_name, :address,
            :delivery_service, :line_items, :status, presence: true

  monetize :total_value_cents,
    numericality: {
      greater_than_or_equal_to: 0
    }

  serialize :line_items, Array

  enum status: %i[ready production closing sent]
end
