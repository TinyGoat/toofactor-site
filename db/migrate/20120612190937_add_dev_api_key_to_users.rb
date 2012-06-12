class AddDevApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dev_api_key, :string
  end
end
