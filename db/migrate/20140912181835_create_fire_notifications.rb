class CreateFireNotifications < ActiveRecord::Migration
  def change
    create_table :fire_notifications do |t|
      t.belongs_to :subscriber
      t.belongs_to :fire_alert
    end
  end
end
