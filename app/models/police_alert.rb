class PoliceAlert < ActiveRecord::Base
  #belongs_to :subscriber
  validates_presence_of :hundred_block_location, :event_clearance_description, :event_clearance_date, 
    :general_offense_number, :census_tract, :latitude, :longitude 

=begin

#require 'open-uri'
#require 'json'

# for 911 POLICE data since 12/31/2009
endpoint = 'http://data.seattle.gov/resource/fw4z-a47w.json'

#query is limited to 1000 records by default
query ="$limit"

url = "#{endpoint}?#{query}"
url = URI.escape(url)

json = open(url).read

alerts = JSON.parse(json)

# deletes parameters not needed by app and converts time
alerts.each do |hash|
  hash.delete("event_clearance_code")
  hash.delete("cad_event_number")
  hash.delete("event_clearance_subgroup")
  hash.delete("event_clearance_group")
  hash.delete("cad_cdw_id")
  hash.delete("zone_beat")
  hash.delete("initial_type_description")
  hash.delete("district_sector")
  hash.delete("initial_type_subgroup")
  hash.delete("initial_type_group")
  hash.delete("incident_location")
  hash.delete("at_scene_time")
  t = Time.parse(hash["event_clearance_date"]) 
  hash["event_clearance_date"] = t.strftime("%a %b %e, %Y at %I:%M %p")
  hash["latitude"] = hash["latitude"].to_f
  hash["longitude"] = hash["longitude"].to_f
end


=end


end