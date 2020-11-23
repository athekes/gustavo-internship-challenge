class Batch < ApplicationRecord
  has_many :orders

  validates :reference, presence: true, uniqueness: { case_sensitive: false }
  validates :purchase_channel, presence: true

  before_validation :set_reference, on: :create

  def set_reference
    self.reference ||= "BT-#{Digest::SHA1.hexdigest([Time.now, rand].join)}"
  end
end
