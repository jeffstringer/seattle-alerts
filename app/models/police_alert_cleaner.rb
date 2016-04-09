class PoliceAlertCleaner

  attr_accessor :hundred_block_location, :event_clearance_description, :event_clearance_date, :general_offense_number, :census_tract,
    :longitude, :latitude, :time_show

  def initialize(options)
    @hundred_block_location = options["hundred_block_location"]
    @event_clearance_description = options["event_clearance_description"]
    @event_clearance_date = options["event_clearance_date"]
    @general_offense_number = options["general_offense_number"]
    @census_tract = options["census_tract"]
    @longitude = options["longitude"]
    @latitude = options["latitude"]
    @time_show = options["time_show"]
    self.set_time
  end 

  def set_time
    set_time_show = Time.parse(event_clearance_date)
    self.time_show = Time.parse(set_time_show.strftime('%a %b %e, %Y at %I:%M %p')).to_s
  end
end