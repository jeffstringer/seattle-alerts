class NotifySubscribers

  def self.call(police_notifications,fire_notifications)
    subscribers = []
    unless police_notifications.nil?
      police_notifications.each do |p|
        subscriber = Subscriber.find(p.subscriber_id)
        subscribers << subscriber unless subscriber == nil
      end
    end

    unless fire_notifications.nil?
      fire_notifications.each do |f|
        subscriber = Subscriber.find(f.subscriber_id)
        subscribers << subscriber unless subscriber == nil
      end
    end
    subscribers.uniq! {|s| s.id }
  end
end