class CreateBookRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :book_requests do |t|
      t.string :name, null: false
      t.text :comment
      t.integer :budget, null: false
      t.integer :quantity, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
