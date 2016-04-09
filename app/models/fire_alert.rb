class FireAlert < ActiveRecord::Base

  validates_presence_of :address, :datetime, :incident_number, :fire_type,
    :latitude, :longitude, :time_show
  validates_uniqueness_of :incident_number

  has_many :fire_notifications, dependent: :destroy
  has_many :subscribers, through: :fire_notifications

  scope :subscriber_new_alerts, -> (subscriber_id) {
    where("fire_alerts.created_at > ?", 15.minute.ago).
    joins(:fire_notifications).
    where("fire_notifications.subscriber_id = ?", subscriber_id).
    order(time_show: :desc).limit(30) 
  }
  scope :subscriber_past_day_alerts, -> (subscriber_id) {
    where("? <= time_show AND time_show <= ?", 1.day.ago, Time.now).
    joins(:fire_notifications).
    where("fire_notifications.subscriber_id = ?", subscriber_id)
  }

  scope :new_alerts, -> { where("created_at >= ?", 15.minute.ago) }
  scope :past_day_alerts, -> { where("? <= time_show AND time_show <= ?", 1.day.ago, Time.now) }

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      if raw_alert.many?
        alert = FireAlertCleaner.new(raw_alert)
        unless alert.type.include?("ALARMS")
          create({address: alert.address, datetime: alert.datetime, incident_number: alert.incident_number,
                  latitude: alert.latitude, longitude: alert.longitude, fire_type: alert.type,
                  time_show: alert.time_show})
        end
      end
    end
  end
end
