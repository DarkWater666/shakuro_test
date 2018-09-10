module StockApiActions
  module ForPublisher
    def self.included(api)
      api.namespace :for_publisher do
        desc 'Returns shops for a specific publisher'

        params do
          requires :publisher_id, type: Integer, desc: 'ID of publisher'
        end

        route_param :publisher_id do
          get do
            publisher = Publisher.find permitted_params[:publisher_id]
            publisher_books = publisher.books
                                       .joins(:shops, :stocks)
                                       .where('stocks.stock_count > 0')
                                       .select('books.*, shops.id as shop_id, stocks.stock_count as copies_in_stock')
                                       .distinct
            shops = Shop.joins(:stocks)
                        .where(stocks: { book: publisher_books.uniq })
                        .select('shops.*, SUM(stocks.sold_count) as books_sold_count')
                        .distinct.group(:id).order('books_sold_count DESC')
            return error!({ error: :not_found, detail: 'publisher not have books' }, 404) if publisher_books.empty?
            present shops, with: ::Entities::ShopsEntity, books: publisher_books
          end
        end
      end
    end
  end
end
