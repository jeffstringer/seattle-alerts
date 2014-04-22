class PoliceAlert < ActiveRecord::Base
  #belongs_to :subscriber
  validates_presence_of :hundred_block_location, :event_clearance_description, :event_clearance_date, 
    :general_offense_number, :census_tract, :latitude, :longitude, :time_show

  validates_uniqueness_of :general_offense_number  

  # for 911 POLICE data since 04/01/2013
  endpoint = 'http://data.seattle.gov/resource/fw4z-a47w.json'

  #query is limited to 1000 records by default, approximately 1 day
  query ="$limit=1000"

  url = "#{endpoint}?#{query}"
  url = URI.escape(url)

  json = open(url).read

  police_alerts = JSON.parse(json)

  # deletes parameters not needed by app and converts time
  police_alerts.each do |police_alert|
    police_alert.delete("event_clearance_code")
    police_alert.delete("cad_event_number")
    police_alert.delete("event_clearance_subgroup")
    police_alert.delete("event_clearance_group")
    police_alert.delete("cad_cdw_id")
    police_alert.delete("zone_beat")
    police_alert.delete("initial_type_description")
    police_alert.delete("district_sector")
    police_alert.delete("initial_type_subgroup")
    police_alert.delete("initial_type_group")
    police_alert.delete("incident_location")
    police_alert.delete("at_scene_time")
    police_alert["time_show"] = police_alert["event_clearance_date"]
    t = Time.parse(police_alert["event_clearance_date"]) 
    police_alert["event_clearance_date"] = t.strftime("%a %b %e, %Y at %I:%M %p")
    police_alert["time_show"] = Time.parse(police_alert["event_clearance_date"]).to_s 
    police_alert["latitude"] = police_alert["latitude"].to_f
    police_alert["longitude"] = police_alert["longitude"].to_f
    #police_alert["event_clearance_description"] = police_alert["event_clearance_description"].titleize
    #police_alert["hundred_block_location"] = police_alert["hundred_block_location"].downcase
    #police_alert["hundred_block_location"] = police_alert["hundred_block_location"].titleize
  end

  police_alerts.each do |police_alert|
    police_alert = PoliceAlert.new(police_alert)
    if PoliceAlert.exists?(general_offense_number: police_alert["general_offense_number"]) == false
      police_alert.save
    end  
  end
end
