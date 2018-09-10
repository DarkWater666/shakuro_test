module Entities
  class StocksEntity < Grape::Entity
    expose :shop_id, :book_id, :stock_count, :sold_count
  end
end
