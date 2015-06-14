class PoliceAlert < ActiveRecord::Base
  validates_presence_of :hundred_block_location, :event_clearance_description,
    :event_clearance_date, :general_offense_number, :census_tract, :latitude,
    :longitude, :time_show
  validates_uniqueness_of :general_offense_number
  has_many :police_notifications, dependent: :destroy
  has_many :subscribers, through: :police_notifications

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      raw_alert = raw_alert.slice!('event_clearance_code','cad_event_number','event_clearance_subgroup',
       'event_clearance_group','cad_cdw_id','zone_beat','initial_type_description','district_sector',
       'initial_type_subgroup','initial_type_group','incident_location','at_scene_time')
      raw_alert['time_show'] = raw_alert['event_clearance_date']
      t = Time.parse(raw_alert['event_clearance_date'])
      raw_alert['event_clearance_date'] = t.strftime('%a %b %e, %Y at %I:%M %p')
      raw_alert['time_show'] = Time.parse(raw_alert['event_clearance_date']).to_s
      create_alert(raw_alert)
    end
  end

  def self.create_alert(raw_alert)
    create(raw_alert) unless exists?(general_offense_number: raw_alert['general_offense_number'])
  end

  def self.alerts_past_day
    self.where(time_show: (Time.now - 1.day)..Time.now)
  end

  def self.sub_alerts_past_day(subscriber)
    subscriber.police_alerts.where(time_show: (Time.now - 1.day)..Time.now)
  end
end

SeattleAlert.call if Rails.env.development?

