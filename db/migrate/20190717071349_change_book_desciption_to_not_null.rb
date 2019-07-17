class ChangeBookDesciptionToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :description, :text, null: false
  end
end
