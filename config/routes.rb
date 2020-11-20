Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/orders', to: 'orders#create'
      get '/orders', to: 'orders#orders_by_purchase_channel'
      get '/orders/status', to: 'orders#status'

      post '/batches', to: 'batches#create'
      get '/batches', to: 'batches#show'
      put '/batches/produce', to: 'batches#produce'
      put '/batches/closing', to: 'batches#closing'
      put '/batches/sent', to: 'batches#sent'
    end
  end
end
