RSpec.describe 'Productions', type: :request do
  describe 'PUT /batches/productions/:reference' do
    it 'if found, set orders to production' do
      batch = create(:batch) do |batch|
        create_list(:order, 5, batch: batch)
      end

      put api_v1_batches_production_path(batch.reference)

      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('production')
    end
  end
end