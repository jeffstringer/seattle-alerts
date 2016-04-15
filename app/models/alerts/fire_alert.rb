class FireAlert < ActiveRecord::Base

  validates_presence_of :address, :datetime, :incident_number, :fire_type,
    :latitude, :longitude
  validates_uniqueness_of :incident_number

  has_many :fire_notifications, dependent: :destroy
  has_many :subscribers, through: :fire_notifications

  scope :subscriber_new_alerts, -> (subscriber_id) {
    where("fire_alerts.created_at > ?", 15.minute.ago).
    joins(:fire_notifications).
    where("fire_notifications.subscriber_id = ?", subscriber_id).
    order(datetime: :desc).limit(30)
  }
  scope :subscriber_past_day_alerts, -> (subscriber_id) {
    where("? <= datetime AND datetime <= ?", 1.day.ago, Time.now).
    joins(:fire_notifications).
    where("fire_notifications.subscriber_id = ?", subscriber_id)
  }

  scope :new_alerts, -> { where("created_at >= ?", 15.minute.ago) }
  scope :past_day_alerts, -> { where("? <= datetime AND datetime <= ?", 1.day.ago, Time.now) }

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      if raw_alert.many?
        unless raw_alert['type'].include?("Alarm")
          alert = FireAlert.new({address: raw_alert['address'], datetime: raw_alert['datetime'], incident_number: raw_alert['incident_number'],
                    latitude: raw_alert['latitude'], longitude: raw_alert['longitude'], fire_type: raw_alert['type']})
          alert.set_time(raw_alert['datetime'])
          alert.save
        end
      end
    end
  end

  def set_time(date)
    self.datetime = Time.at(date)
  end
end
