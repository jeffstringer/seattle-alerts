class FireAlert < ActiveRecord::Base
  validates_presence_of :address, :datetime, :incident_number, :fire_type,
    :latitude, :longitude, :time_show
  validates_uniqueness_of :incident_number
  has_many :fire_notifications
  has_many :subscribers, through: :fire_notifications

  def self.fetch_fire_data
    endpoint = 'http://data.seattle.gov/resource/4ss6-4s75.json' 
    timestamp = (Time.now - (60 * 60 * 24)).strftime('%F %H:%M:%S')
    query = "$where=datetime > '#{timestamp}'"
    url = "#{endpoint}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    fire_alerts = JSON.parse(json)
  end

  def self.parse_fire_data(array)
    array.each do |fire_alert|
      if fire_alert.length > 1
        # fire_alert.delete('report_location')
        fire_alert['time_show'] = Time.at(fire_alert['datetime'])
        fire_alert['datetime'] = Time.at(fire_alert['datetime']).strftime('%a %b %e, %Y at %I:%M %p')
        fire_alert['fire_type'] = fire_alert['type']
        # fire_alert.delete('type')
        fire_alert = fire_alert.slice!('type','report_location')
      end
      new_alert = FireAlert.new(fire_alert)
      if FireAlert.exists?(incident_number: fire_alert['incident_number']) == false
        new_alert.save
      end
    end
  end

  def self.alerts
    self.where(time_show: (Time.now - 1.day)..Time.now)
  end

  def self.create_fire_notifications
    self.all.each do |f_alert|
      Subscriber.all.each do |subscriber|
        fire_notification = FireNotification.new
        fire_notification.subscriber_id = subscriber.id
        fire_notification.fire_alert_id = f_alert.id
        if subscriber.distance_to([f_alert.latitude, f_alert.longitude]) <= subscriber.radius && FireNotification.exists?(fire_alert_id: fire_notification.fire_alert_id) == false
          fire_notification.save
        end 
      end
    end
  end  
end

FireAlert.parse_fire_data(FireAlert.fetch_fire_data)
FireAlert.create_fire_notifications
