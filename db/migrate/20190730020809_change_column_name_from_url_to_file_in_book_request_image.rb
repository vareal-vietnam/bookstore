class ChangeColumnNameFromUrlToFileInBookRequestImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :book_request_images, :url, :file
  end
end
