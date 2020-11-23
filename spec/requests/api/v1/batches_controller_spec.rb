RSpec.describe 'Batches', type: :request do
  describe 'POST /batches' do
    context 'with valid params and orders avaliables' do
      it 'create a batch' do
        create(:order, purchase_channel: 'Site A')
        post api_v1_batches_path, params: { purchase_channel: 'Site A' }

        expect(response).to have_http_status(:created)
      end
    end
    context 'with valid params and no orders avaliables' do
      it 'create a batch' do
        post api_v1_batches_path, params: { purchase_channel: 'Site A' }

        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with invalid params' do
      it 'not create a batch' do
        post api_v1_batches_path, params: { arbitrary_param: 'anything' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
