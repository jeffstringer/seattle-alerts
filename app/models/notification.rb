module Notification

  def create_notifications
    alert_type.new_alerts.each do |alert|
      Subscriber.all.each do |subscriber|
        if subscriber.distance_to([alert.latitude, alert.longitude]) <= subscriber.radius && 
          !self.exists?(alert_id => alert.id)
          self.create(subscriber_id: subscriber.id, alert_id => alert.id)
        end
      end
    end
  end

  def alert_name
    alert = self.name.split /(?=[A-Z])/
    alert.first
  end

  def alert_type
    (alert_name + "Alert").constantize
  end

  def alert_id
    (alert_name.downcase + "_alert_id").to_sym
  end
end