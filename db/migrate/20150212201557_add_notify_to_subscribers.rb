class AddNotifyToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :notify, :boolean, null: true, default: true
  end
end
