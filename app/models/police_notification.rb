class PoliceNotification < ActiveRecord::Base

  belongs_to :subscriber
  belongs_to :police_alert

  scope :recent_notifications, -> { where("created_at >= ?", 15.minute.ago) }

  def self.create_notifications
    PoliceAlert.recent_alerts.each do |alert|
      Subscriber.all.each do |subscriber|
        if subscriber.distance_to([alert.latitude, alert.longitude]) <= subscriber.radius && 
          !self.exists?(police_alert_id: alert.id)
          self.create(subscriber_id: subscriber.id, police_alert_id: alert.id)
        end
      end
    end
  end
end
