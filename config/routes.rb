Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :batches, only: %i[index show create], param: :reference
      namespace :batches do
        resources :productions, only: :update, param: :reference
        resources :closings, only: :update, param: :reference
        resources :shipments, only: :update, param: :reference
      end

      get 'orders/show/:reference', to: 'orders#show'

      resources :orders, only: :create
      namespace :orders do
        get '/status', to: 'orders_with_status#show'
        get '/purchase_channel', to: 'purchase_channel_orders#index'
      end
    end
  end
end
