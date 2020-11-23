require 'rails_helper'

RSpec.describe Batch do
  subject { create(:batch) }

  describe 'associations' do
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:reference) }
    it { should validate_uniqueness_of(:reference).case_insensitive }
    it { should validate_presence_of(:purchase_channel) }
  end
end