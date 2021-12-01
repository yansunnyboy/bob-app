class AddParamsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :bio, :string
    add_column :products, :info, :text
    add_column :products, :image_url, :string
  end
end
