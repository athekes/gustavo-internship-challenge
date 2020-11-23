RSpec.describe 'Shipments', type: :request do
  describe 'PUT /batches/shipments/:reference' do
    context 'whem only reference as a param' do
      it 'if found, set orders to shipment' do
        batch = create(:batch) do |batch|
          create_list(:order, 5, batch: batch)
        end

        put api_v1_batches_shipment_path(batch.reference)

        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('sent')
      end
    end
    context 'when has a delivery_service as a param' do
      it 'if found, set only orders of a delivery service to shipment' do
        delivery_service = 'pac'

        batch = create(:batch) do |batch|
          create_list(:order, 3, batch: batch, delivery_service: 'other')
          create_list(:order, 2, batch: batch, delivery_service: delivery_service)
        end

        put api_v1_batches_shipment_path(batch.reference), params: { delivery_service: delivery_service }

        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('sent')
        expect(Order.where(status: 'sent').count).to be(2)
      end
    end
  end
end