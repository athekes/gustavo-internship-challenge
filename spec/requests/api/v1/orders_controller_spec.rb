RSpec.describe 'Orders', type: :request do
  describe 'POST /orders ' do
    context 'with valid params' do
      it 'create a batch' do
        post api_v1_orders_path, params: attributes_for(:order)

        expect(response).to have_http_status(:created)
      end
      context 'with invalid params' do
        it 'not create a batch' do
          post api_v1_orders_path, params: { arbitrary_param: 'anything' }

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
