class CreatePoliceNotifications < ActiveRecord::Migration
  def change
    create_table :police_notifications do |t|
      t.belongs_to :subscriber
      t.belongs_to :police_alert
    end
  end
end
