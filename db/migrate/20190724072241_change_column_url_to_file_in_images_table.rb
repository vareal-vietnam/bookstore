class ChangeColumnUrlToFileInImagesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :url
    add_column :images, :file, :string, null: false
  end
end
