class PoliceAlert < ActiveRecord::Base

  validates_presence_of :hundred_block_location, :event_clearance_description,
    :event_clearance_date, :general_offense_number, :census_tract, :latitude,
    :longitude
  validates_uniqueness_of :general_offense_number

  has_many :police_notifications, dependent: :destroy
  has_many :subscribers, through: :police_notifications

  scope :subscriber_new_alerts, -> (subscriber_id) {
    where("police_alerts.created_at > ?", 15.minute.ago).
    joins(:police_notifications).
    where("police_notifications.subscriber_id = ?", subscriber_id).
    order(event_clearance_date: :desc).limit(30)
  }
  scope :subscriber_past_day_alerts, -> (subscriber_id) {
    where("? <= event_clearance_date AND event_clearance_date <= ?", 1.day.ago, Time.now).
    joins(:police_notifications).
    where("police_notifications.subscriber_id = ?", subscriber_id)
  }

  scope :new_alerts, -> { where("created_at >= ?", 15.minute.ago) }
  scope :past_day_alerts, -> { where("? <= event_clearance_date AND event_clearance_date <= ?", 1.day.ago, Time.now) }

  def self.parse_data(raw_alerts)
    raw_alerts.each do |raw_alert|
      unless raw_alert['event_clearance_description'].include?("alarms")
        alert = PoliceAlert.new({hundred_block_location: raw_alert['hundred_block_location'], event_clearance_description: raw_alert['event_clearance_description'],
          event_clearance_date: raw_alert['event_clearance_date'], general_offense_number: raw_alert['general_offense_number'],
          census_tract: raw_alert['census_tract'], latitude: raw_alert['latitude'], longitude: raw_alert['longitude']})
        alert.set_time
        alert.save
      end
    end
  end

  def set_time
    self.event_clearance_date = Time.parse(event_clearance_date.to_s)
  end
end

SeattleAlert.call if Rails.env.development?

