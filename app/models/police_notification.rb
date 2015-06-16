class PoliceNotification < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :police_alert

  def self.create_police_notifications
    self.recent_police_alerts.each do |p_alert|
      Subscriber.all.each do |subscriber|
        if subscriber.distance_to([p_alert.latitude, p_alert.longitude]) <= subscriber.radius && 
          !self.exists?(police_alert_id: p_alert.id)
          self.create(subscriber_id: subscriber.id, police_alert_id: p_alert.id)
        end
      end
    end
  end

  private

    def self.recent_police_alerts
      t = 15.minute.ago
      PoliceAlert.where("created_at >= ?", t)
    end
end
