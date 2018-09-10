require 'faker'

rand(10..20).times { Publisher.create name: Faker::Book.publisher }
rand(100..200).times { Book.create title: Faker::Book.title }
rand(5..10).times { Shop.create name: Faker::Commerce.department(2, true) }

Book.order(Arel.sql('random()')).find_each do |book|
  book.update publisher_id: Publisher.order(Arel.sql('random()')).first.id
  shop_ids = []
  rand(5).times do
    shop = Shop.where.not(id: shop_ids).order(Arel.sql('random()')).first
    shop.stocks.create book: book, stock_count: rand(50), sold_count: rand(50)
    shop_ids << shop.id
  end
end
