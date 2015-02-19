class AddTimestampsToNotifications < ActiveRecord::Migration
  def change
    add_timestamps(:police_notifications)
    add_timestamps(:fire_notifications)
  end
end
