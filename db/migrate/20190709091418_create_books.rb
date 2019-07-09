class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.text :comment
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
