module StockApiActions
  module Sold
    def self.included(api)
      api.namespace :sold do
        desc 'Mark copies a book as sold'

        params do
          requires :shop_id, type: Integer, desc: 'ID of shop'
          requires :book_id, type: Integer, desc: 'ID of book'
          optional :amount, type: Integer, desc: "Amount of sold book's copies", default: 1
        end

        post do
          stock = Stock.find_by shop_id: permitted_params[:shop_id], book_id: permitted_params[:book_id]
          unless stock
            return error!({ error: :not_found, detail: "Shop not found or it doesn't distributed the book" }, 404)
          end
          amount = permitted_params[:amount] || 1
          stock.decrement(:stock_count, amount).increment(:sold_count, amount).save
          present stock, with: ::Entities::StocksEntity
        end
      end
    end
  end
end
