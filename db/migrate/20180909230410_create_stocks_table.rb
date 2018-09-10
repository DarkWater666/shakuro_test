class CreateStocksTable < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.belongs_to :book, index: true
      t.belongs_to :shop, index: true
      t.integer :stock_count, default: 0
      t.integer :sold_count, default: 0

      t.timestamps
    end

    add_index :book_in_shop, %i[book_id shop_id], unique: true
  end
end
