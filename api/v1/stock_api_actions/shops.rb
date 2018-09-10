module StockApiActions
  module Shops
    def self.included(api)
      api.namespace :shops do
        desc 'Returns all shops'

        get do
          present Shop.all, with: ::Entities::ShopsEntity
        end
      end
    end
  end
end
