class AddRememberTokenToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :remember_token, :string
    add_index  :subscribers, :remember_token
  end
end
