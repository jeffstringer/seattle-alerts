class PoliceAlert < ActiveRecord::Base
  validates_presence_of :hundred_block_location, :event_clearance_description,
    :event_clearance_date, :general_offense_number, :census_tract, :latitude,
    :longitude, :time_show
  validates_uniqueness_of :general_offense_number
  has_many :police_notifications
  has_many :subscribers, through: :police_notifications

  def self.fetch_police_data
    endpoint = 'http://data.seattle.gov/resource/fw4z-a47w.json'
    # query is limited to 1000 records by default, approximately 1 day
    query ="$limit=1000"
    url = "#{endpoint}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    police_alerts = JSON.parse(json)
  end

  def self.parse_police_data(array)
    array.each do |police_alert|
      police_alert = police_alert.slice!('event_clearance_code','cad_event_number','event_clearance_subgroup',
       'event_clearance_group','cad_cdw_id','zone_beat','initial_type_description','district_sector',
       'initial_type_subgroup','initial_type_group','incident_location','at_scene_time')
      police_alert['time_show'] = police_alert['event_clearance_date']
      t = Time.parse(police_alert['event_clearance_date'])
      police_alert['event_clearance_date'] = t.strftime('%a %b %e, %Y at %I:%M %p')
      police_alert['time_show'] = Time.parse(police_alert['event_clearance_date']).to_s
      new_alert = PoliceAlert.new(police_alert)
      if PoliceAlert.exists?(general_offense_number: police_alert['general_offense_number']) == false
        new_alert.save
      end
    end
  end

  def self.create_police_notifications
      self.all.each do |p_alert|
      Subscriber.all.each do |subscriber|
        police_notification = PoliceNotification.new
        police_notification.subscriber_id = subscriber.id
        police_notification.police_alert_id = p_alert.id
        if subscriber.distance_to([p_alert.latitude, p_alert.longitude]) <= subscriber.radius && PoliceNotification.exists?(police_alert_id: police_notification.police_alert_id) == false
          police_notification.save
        end   
      end
    end
  end

  def self.alerts
    self.where(time_show: (Time.now - 1.day)..Time.now)
  end
end

PoliceAlert.parse_police_data(PoliceAlert.fetch_police_data)
PoliceAlert.create_police_notifications
