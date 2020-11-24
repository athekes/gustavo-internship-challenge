RSpec.describe 'Orders purchase_channel', type: :request do
  describe 'GET /orders/purchase_channel ' do
    context 'with only purchase_channel as a param' do
      it 'if found, shows all the orders of that purchase channel' do
        purchase_channel = 'Site A'
        create_list(:order, 5, purchase_channel: purchase_channel)

        get api_v1_orders_purchase_channel_path, params: { orders: { purchase_channel: purchase_channel } }

        json_response = JSON.parse(response.body)
        expect(json_response['data'].count).to be(5)
      end
      it 'if not found, return 404' do
        purchase_channel = 'Site A'

        get api_v1_orders_purchase_channel_path, params: { orders: { purchase_channel: purchase_channel } }

        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with status and purchase_channel as a param' do
      it 'if found, shows only the orders of that purchase channel with have that status' do
        purchase_channel = 'Site A'
        status = 'production'
        create_list(:order, 3, purchase_channel: purchase_channel, status: 'ready')
        create_list(:order, 2, purchase_channel: purchase_channel, status: status)

        get api_v1_orders_purchase_channel_path, params: { orders: { purchase_channel: purchase_channel, status: status } }

        json_response = JSON.parse(response.body)
        expect(json_response['data'].count).to be(2)
      end
      it 'if not found, return 404' do
        purchase_channel = 'Site A'
        status = 'production'
        create_list(:order, 5, purchase_channel: purchase_channel, status: 'ready')

        get api_v1_orders_purchase_channel_path, params: { orders: { purchase_channel: purchase_channel, status: status } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
