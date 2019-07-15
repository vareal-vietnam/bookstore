class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url, null: false
      t.references :book, foreign_key: true, null: false

      t.timestamps
    end
  end
end
