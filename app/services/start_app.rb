class StartApp

  def self.call
    self.call_police
    self.call_fire
    self.call_notifications
  end

  def self.call_police
    police_data = PoliceData.new
    police_results = police_data.fetch('http://data.seattle.gov/resource/fw4z-a47w.json')
    PoliceAlert.parse_police_data(police_results)
    PoliceNotification.create_police_notifications
  end

  def self.call_fire
    fire_data = FireData.new
    fire_results = fire_data.fetch('http://data.seattle.gov/resource/4ss6-4s75.json')
    FireAlert.parse_fire_data(fire_results)
    FireNotification.create_fire_notifications
  end

  def self.call_notifications
    t = Time.now
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