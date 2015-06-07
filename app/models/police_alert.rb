class PoliceAlert < ActiveRecord::Base
  validates_presence_of :hundred_block_location, :event_clearance_description,
    :event_clearance_date, :general_offense_number, :census_tract, :latitude,
    :longitude, :time_show
  validates_uniqueness_of :general_offense_number
  has_many :police_notifications, dependent: :destroy
  has_many :subscribers, through: :police_notifications

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

  def self.alerts
    self.where(time_show: (Time.now - 1.day)..Time.now)
  end

  def self.subscriber_alerts(subscriber)
    subscriber.police_alerts.where(time_show: (Time.now - 1.day)..Time.now)
  end
end

if Rails.env.development?
  SeattleAlert.call
end

