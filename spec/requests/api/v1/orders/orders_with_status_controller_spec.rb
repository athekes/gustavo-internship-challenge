RSpec.describe 'Orders status', type: :request do
  describe 'GET /orders/status ' do
    context 'with only reference as a param' do
      it 'if found, shows the order and its status' do
        reference = 'OD-1'
        create(:order, reference: reference)

        get api_v1_orders_status_path, params: { orders: { reference: reference } }

        json_response = JSON.parse(response.body)
        expect(json_response['orders'].first['reference']).to eq(reference)
      end
      it 'if not found, return 404' do
        reference = 'OD-1'

        get api_v1_orders_status_path, params: { orders: { reference: reference } }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with has a client_name as a param' do
      it 'if found, shows a list of orders' do
        client_name = "jhon"
        create_list(:order, 5, client_name: client_name)

        get api_v1_orders_status_path, params: { orders: { client_name: client_name } }

        json_response = JSON.parse(response.body)
        expect(json_response['orders'].count).to eq(5)
      end

      it 'if not found, return 404' do
        client_name = "jhon"

        get api_v1_orders_status_path, params: { orders: { client_name: client_name } }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end