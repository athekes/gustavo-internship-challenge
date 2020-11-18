class Batch < ApplicationRecord
  has_many :orders

  validates :reference, :purchase_channel, presence: true
end
