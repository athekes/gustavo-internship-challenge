RSpec.describe 'Closings', type: :request do
  describe 'PUT /batches/closings/:reference' do
    it 'if found, set orders to closing' do
      batch = create(:batch) do |batch|
        create_list(:order, 5, batch: batch)
      end

      put api_v1_batches_closing_path(batch.reference)

      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('closing')
    end
    it 'if not found, return 404' do
      reference = 'anything'
      put api_v1_batches_closing_path(reference)

      expect(response).to have_http_status(:not_found)
    end
  end
end