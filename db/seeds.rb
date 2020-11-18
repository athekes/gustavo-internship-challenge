
Batch.create(
  reference: '123',
  purchase_channel: 'Site-BR',
)

Order.create(
  reference: 'BR102030',
  purchase_channel: 'Site BR',
  client_name: 'Rogerio Lima',
  address: 'Rua Padre Valdevino, 2475 - Aldeota, Fortaleza - CE, 60135-041',
  delivery_service: 'SEDEX',
  line_items: [
    { sku: 'case-my-best-friend', model: 'iPhone X', case_type: 'Rose Leather' },
    { sku: 'powebank-sunshine', capacity: '10000mah' },
    { sku: 'earphone-standard', color: 'white' }
  ],
  total_value: 1000,
  status: 'ready',
  batch: Batch.last
)

p '###### Seed realizada com sucesso ######'
