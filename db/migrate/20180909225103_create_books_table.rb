class CreateBooksTable < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.belongs_to :publisher, index: true

      t.timestamps
    end
  end
end
