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
    it 'if not found, return 404' do
      reference = 'anything'
      put api_v1_batches_production_path(reference)

      expect(response).to have_http_status(:not_found)
    end
  end
end