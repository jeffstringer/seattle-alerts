class FireAlert < ActiveRecord::Base
    #belongs_to :subscriber
  validates_presence_of :address, :datetime, :incident_number, :fire_type, :latitude, :longitude
  
=begin
  # ACCESSING FIRE DATA
require 'open-uri'
require 'json'

# for ALL 911 Fire data
#endpoint = 'http://data.seattle.gov/resource/kzjm-xkqj.json'
# for 911 fire data for fire calls only and since 12/31/2009
endpoint = 'http://data.seattle.gov/resource/4ss6-4s75.json'

# query for calls for last hour: 60 seconds * 60 minutes
timestamp = (Time.now - (60 * 60 * 24 * 7)).strftime("%F %H:%M:%S")
query = "$where=datetime > '#{timestamp}'"
 
# query for calls since 1/1/2013 at limit of 1000:
  #current_time = (Time.now).strftime("%F %H:%M:%S")
  #time_begin = "2013-01-01 00:00:00"
  #query = "$where=datetime > '#{time_begin}'"

#query is limited to 1000 records by default:
#query ="$limit"

url = "#{endpoint}?#{query}"
url = URI.escape(url)

json = open(url).read

result = JSON.parse(json)

result.each do |hash|
  # FIRE: convert unix time to ISO 8601 format
  if hash.length > 6
    hash.delete("report_location")
    hash["datetime"] = Time.at(hash["datetime"]).strftime("%a %b %e, %Y at %I:%M %p")
    hash["latitude"] = hash["latitude"].to_f
    hash["longitude"] = hash["longitude"].to_f
    hash["fire_type"] = hash["type"]
    hash.delete("type")
  end  
end 
=end

end

