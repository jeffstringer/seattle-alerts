class FireNotification < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :fire_alert

  def self.create_fire_notifications
    FireAlert.all.each do |f_alert|
      Subscriber.all.each do |subscriber|
        fire_notification = FireNotification.new(subscriber_id: subscriber.id, fire_alert_id: f_alert.id)
        if subscriber.distance_to([f_alert.latitude, f_alert.longitude]) <= subscriber.radius && 
          FireNotification.exists?(fire_alert_id: fire_notification.fire_alert_id) == false
          fire_notification.save
          FIRE_NOTIFICATIONS << fire_notification
        end 
      end
    end
  end
end