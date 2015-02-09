class PoliceNotification < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :police_alert

  def self.create_police_notifications
    PoliceAlert.all.each do |p_alert|
      Subscriber.all.each do |subscriber|
        police_notification = PoliceNotification.new(subscriber_id: subscriber.id, police_alert_id: p_alert.id)
        if subscriber.distance_to([p_alert.latitude, p_alert.longitude]) <= subscriber.radius && 
          PoliceNotification.exists?(police_alert_id: police_notification.police_alert_id) == false
          police_notification.save
          POLICE_NOTIFICATIONS << police_notification
        end   
      end
    end
  end
end
