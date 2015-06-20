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
    PoliceNotification.create_notifications
  end

  def self.call_fire
    fire_data = FireData.new('http://data.seattle.gov/resource/4ss6-4s75.json')
    fire_results = fire_data.fetch
    FireAlert.parse_data(fire_results)
    FireNotification.create_notifications
  end

  def self.call_notifications
    subscribers = self.subscribers_to_notify
    subscribers.each do |subscriber|
      SubscriberMailer.notification_email(subscriber.id).deliver_now! if subscriber.notify?
    end
  end

  private   

    def self.subscribers_to_notify
      police_notifications = PoliceNotification.new_notifications
      fire_notifications = FireNotification.new_notifications
      subscriber_ids = (police_notifications.pluck(:subscriber_id) + fire_notifications.pluck(:subscriber_id)).uniq!
      subscribers = Subscriber.where(id: subscriber_ids)
    end
end