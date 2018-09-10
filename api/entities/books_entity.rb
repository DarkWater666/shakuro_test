module Entities
  class BooksEntity < Grape::Entity
    expose :id, :title
    expose :copies_in_stock, if: ->(object, _options) { object.copies_in_stock.present? }
  end
end
