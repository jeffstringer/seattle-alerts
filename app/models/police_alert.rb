class PoliceAlert < ActiveRecord::Base
  #belongs_to :subscriber
  validates_presence_of :hundred_block_location, :event_clearance_description, :event_clearance_date, 
    :general_offense_number, :census_tract, :latitude, :longitude

end
