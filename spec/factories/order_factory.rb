FactoryBot.define do
  factory :order do
    sequence(:reference) { |i| "OD-#{i}" }
    purchase_channel { ['Site A', 'Site B', 'Site C'].sample }
    client_name { Faker::Name.name }
    address { Faker::Address.street_address }
    delivery_service { ['Sedex', 'Pac', 'Privado'].sample }
    status { 'ready' }
    total_value_cents { 1000 }
    line_items {[
      { sku: 'case-my-best-friend', model: 'iPhone X', case_type: 'Rose Leather' },
      { sku: 'powebank-sunshine', capacity: '10000mah' },
      { sku: 'earphone-standard', color: 'white' }
    ]}
  end
end
