class CreateBookRequestImages < ActiveRecord::Migration[5.2]
  def change
    create_table :book_request_images do |t|
      t.string :url, null: false
      t.references :book_request, foreign_key: true

      t.timestamps
    end
  end
end
