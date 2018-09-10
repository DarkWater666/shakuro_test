require 'factory_bot'

FactoryBot.define do
  factory :stock do
    shop
    book
    stock_count { rand(20) }
    sold_count { rand(10) }
  end

  factory :shop do
    sequence(:name) { |n| "Test Shop №#{n}" }
  end

  factory :book do
    sequence(:title) { |n| "Test Book №#{n}" }
    publisher
  end

  factory :publisher do
    name { 'Test Publisher' }
    transient do
      books_count { 5 }
    end
    after(:create) do |publisher, evaluator|
      create_list(:book, evaluator.books_count, publisher: publisher)
    end
  end
end
