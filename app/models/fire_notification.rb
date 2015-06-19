class FireNotification < ActiveRecord::Base

  belongs_to :subscriber
  belongs_to :fire_alert

  def self.create_fire_notifications
    self.recent_fire_alerts.each do |f_alert|
      Subscriber.all.each do |subscriber|
        if subscriber.distance_to([f_alert.latitude, f_alert.longitude]) <= subscriber.radius && 
          !self.exists?(fire_alert_id: f_alert.id)
          self.create(subscriber_id: subscriber.id, fire_alert_id: f_alert.id)
        end
      end
    end
  end

  private

    def self.recent_fire_alerts
      t = 15.minute.ago
      FireAlert.where("created_at >= ?", t)
    end
end