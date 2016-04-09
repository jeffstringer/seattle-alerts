class PoliceAlert < ActiveRecord::Base

  validates_presence_of :hundred_block_location, :event_clearance_description,
    :event_clearance_date, :general_offense_number, :census_tract, :latitude,
    :longitude, :time_show
  validates_uniqueness_of :general_offense_number

  has_many :police_notifications, dependent: :destroy
  has_many :subscribers, through: :police_notifications

  scope :subscriber_new_alerts, -> (subscriber_id) {
    where("police_alerts.created_at > ?", 15.minute.ago).
    joins(:police_notifications).
    where("police_notifications.subscriber_id = ?", subscriber_id).
    order(time_show: :desc).limit(30) 
  }
  scope :subscriber_past_day_alerts, -> (subscriber_id) {
    where("? <= time_show AND time_show <= ?", 1.day.ago, Time.now).
    joins(:police_notifications).
    where("police_notifications.subscriber_id = ?", subscriber_id)
  }

  scope :new_alerts, -> { where("created_at >= ?", 15.minute.ago) }
  scope :past_day_alerts, -> { where("? <= time_show AND time_show <= ?", 1.day.ago, Time.now) }

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      alert = PoliceAlertCleaner.new(raw_alert)
      unless alert.event_clearance_description.include?("ALARMS")
        create({hundred_block_location: alert.hundred_block_location, event_clearance_description: alert.event_clearance_description,
          event_clearance_date: alert.event_clearance_date, general_offense_number: alert.general_offense_number,
          census_tract: alert.census_tract, latitude: alert.latitude, longitude: alert.longitude, time_show: alert.time_show})
      end
    end
  end
end

SeattleAlert.call if Rails.env.development?

