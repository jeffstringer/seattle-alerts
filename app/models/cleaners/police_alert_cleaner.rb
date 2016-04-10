class PoliceAlertCleaner

  attr_accessor :hundred_block_location, :event_clearance_description, :event_clearance_date, :general_offense_number, :census_tract,
    :longitude, :latitude

  def initialize(options)
    @hundred_block_location = options["hundred_block_location"]
    @event_clearance_description = options["event_clearance_description"]
    @event_clearance_date = options["event_clearance_date"]
    @general_offense_number = options["general_offense_number"]
    @census_tract = options["census_tract"]
    @longitude = options["longitude"]
    @latitude = options["latitude"]
    self.set_time
  end 

  def set_time
    self.event_clearance_date = Time.parse(event_clearance_date)
  end
end