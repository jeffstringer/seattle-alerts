class SeattleAlert

  def self.call
    call_police
    call_fire
    call_notifications
  end

  def self.call_police
    police_data = PoliceData.new('http://data.seattle.gov/resource/fw4z-a47w.json')
    police_results = police_data.fetch
    PoliceAlert.parse_data(police_results)
    PoliceNotification.create_police_notifications
  end

  def self.call_fire
    fire_data = FireData.new('http://data.seattle.gov/resource/4ss6-4s75.json')
    fire_results = fire_data.fetch
    FireAlert.parse_data(fire_results)
    FireNotification.create_fire_notifications
  end

  def self.call_notifications
    t = Time.now
    police_notifications = PoliceNotification.where("created_at >= ?", t)
    fire_notifications = FireNotification.where("created_at >= ?", t)
    subscribers = NotifySubscribers.call(police_notifications, fire_notifications)
    unless subscribers.nil?
      subscribers.each do |subscriber|
        SubscriberMailer.notification_email(police_notifications, fire_notifications, subscriber).deliver_now! if subscriber.notify?
      end
    end
  end
end