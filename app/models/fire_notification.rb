class FireNotification < ActiveRecord::Base

  belongs_to :subscriber
  belongs_to :fire_alert

  scope :new_notifications, -> { where("created_at >= ?", 15.minute.ago) }

  def self.create_notifications
    FireAlert.new_alerts.each do |alert|
      Subscriber.all.each do |subscriber|
        if subscriber.distance_to([alert.latitude, alert.longitude]) <= subscriber.radius && 
          !self.exists?(fire_alert_id: alert.id)
          self.create(subscriber_id: subscriber.id, fire_alert_id: alert.id)
        end
      end
    end
  end
end