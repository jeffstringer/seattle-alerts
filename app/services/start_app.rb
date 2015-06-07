class StartApp

  def self.call
    t = Time.now
    PoliceAlert.parse_police_data(PoliceAlert.fetch_police_data)
    PoliceNotification.create_police_notifications
    FireAlert.parse_fire_data(FireAlert.fetch_fire_data)
    FireNotification.create_fire_notifications
    police_notifications = PoliceNotification.where("created_at >= ?", t)
    fire_notifications = FireNotification.where("created_at >= ?", t)
    subscribers = NotifySubscribers.call(police_notifications, fire_notifications)
    unless subscribers.nil?
      subscribers.each do |subscriber|
        SubscriberMailer.notification_email(police_notifications, fire_notifications, subscriber).deliver! if subscriber.notify == true
      end
    end
  end
end