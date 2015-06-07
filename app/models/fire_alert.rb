class FireAlert < ActiveRecord::Base
  validates_presence_of :address, :datetime, :incident_number, :fire_type,
    :latitude, :longitude, :time_show
  validates_uniqueness_of :incident_number
  has_many :fire_notifications, dependent: :destroy
  has_many :subscribers, through: :fire_notifications

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      if raw_alert.length > 1
        raw_alert['time_show'] = Time.at(raw_alert['datetime'])
        raw_alert['datetime'] = Time.at(raw_alert['datetime']).strftime('%a %b %e, %Y at %I:%M %p')
        raw_alert['fire_type'] = raw_alert['type']
        raw_alert = raw_alert.slice!('type','report_location')
      end
      create_alert(raw_alert)
    end
  end

  def self.create_alert(raw_alert)
    create(raw_alert) unless exists?(incident_number: raw_alert['incident_number'])
  end

  def self.alerts_past_day
    self.where(time_show: (Time.now - 1.day)..Time.now)
  end

  def self.sub_alerts_past_day(subscriber)
    subscriber.fire_alerts.where(time_show: (Time.now - 1.day)..Time.now)
  end
end
