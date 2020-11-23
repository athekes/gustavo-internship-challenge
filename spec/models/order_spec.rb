require 'rails_helper'

RSpec.describe Order do
  subject { create(:order) }

  describe 'associations' do
    it { should belong_to(:batch) }
  end

  describe 'validations' do
    it { should validate_presence_of(:reference) }
    it { should validate_uniqueness_of(:reference).case_insensitive }
    it { should validate_presence_of(:purchase_channel) }
    it { should validate_presence_of(:client_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:delivery_service) }
    it { should validate_presence_of(:line_items) }
    it { should validate_presence_of(:status) }
  end
end