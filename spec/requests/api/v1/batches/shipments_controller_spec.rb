RSpec.describe 'Shipments', type: :request do
  describe 'PUT /batches/shipments/:reference' do
    context 'with valid params' do
      it 'if found, set only orders of a delivery service to shipment' do
        delivery_service = 'pac'

        batch = create(:batch) do |batch|
          create_list(:order, 3, batch: batch, delivery_service: 'other')
          create_list(:order, 2, batch: batch, delivery_service: delivery_service)
        end

        put api_v1_batches_shipment_path(batch.reference), params: { options: { delivery_service: delivery_service } }

        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('sent')
        expect(Order.where(status: 'sent').count).to be(2)
      end
      it 'if not found a reference, return 404' do
        delivery_service = 'pac'
        reference = 'BT-1'

        put api_v1_batches_shipment_path(reference), params: { options: { delivery_service: delivery_service } }

        expect(response).to have_http_status(:not_found)
      end

      it 'if not found any order for that delivery service, return 404' do
        delivery_service = 'pac'

        batch = create(:batch) do |batch|
          create_list(:order, 3, batch: batch, delivery_service: 'other')
          create_list(:order, 2, batch: batch, delivery_service: 'other')
        end

        put api_v1_batches_shipment_path(batch.reference), params: { options: { delivery_service: delivery_service } }

        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with invalid params' do
      it 'return 404' do
        delivery_service = 'pac'

        batch = create(:batch) do |batch|
          create_list(:order, 3, batch: batch, delivery_service: 'other')
          create_list(:order, 2, batch: batch, delivery_service: delivery_service)
        end

        put api_v1_batches_shipment_path(batch.reference), params: { options: { arbitrary_param: 'anything' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end