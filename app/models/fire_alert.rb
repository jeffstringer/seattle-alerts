class FireAlert < ActiveRecord::Base
    #belongs_to :subscriber
  validates_presence_of :address, :datetime, :incident_number, :fire_type, :latitude, :longitude
  
=begin

#require 'open-uri'
#require 'json'

# for 911 fire data for fire calls only and since 12/31/2009
endpoint = 'http://data.seattle.gov/resource/4ss6-4s75.json'

# query for calls for month hour: 60 seconds * 60 minutes * 24 hrs * 7 days * 4 weeks
timestamp = (Time.now - (60 * 60 * 24 * 7 * 4)).strftime("%F %H:%M:%S")
query = "$where=datetime > '#{timestamp}'"

url = "#{endpoint}?#{query}"
url = URI.escape(url)

json = open(url).read

result = JSON.parse(json)

# deletes parameters not needed by app and converts time
result.each do |hash|
  # FIRE: convert unix time to ISO 8601 format
  if hash.length > 1
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

