FactoryBot.define do
  factory :batch do
    sequence(:reference) { |i| "BT-#{i}" }
    purchase_channel { ['Site A', 'Site B', 'Site C'].sample }
  end
end