class FireAlert < ActiveRecord::Base
    #belongs_to :subscriber
  validates_presence_of :address, :datetime, :incident_number, :fire_type, :latitude, :longitude

end

