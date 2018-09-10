module Entities
  class ShopsEntity < Grape::Entity
    root :shops

    expose :id, :name
    expose :books_sold_count, if: ->(object, _options) { object.books_sold_count.present? }
    expose :books_in_stock, using: BooksEntity

    private

    def books_in_stock
      options[:books].select { |book| book.shop_id == object.id }
    end
  end
end
