class AddFeaturesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :business_name, :string
  end
end
