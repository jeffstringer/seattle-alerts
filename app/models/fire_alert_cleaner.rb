class FireAlertCleaner

  attr_accessor :address, :datetime, :incident_number, :longitude, :latitude, :type, :time_show

  def initialize(options)
    @address = options["address"]
    @datetime = options["datetime"]
    @incident_number = options["incident_number"]
    @longitude = options["longitude"]
    @latitude = options["latitude"]
    @type = options["type"]
    @time_show = options["time_show"]
    self.set_time
  end 

  def set_time
    self.time_show = Time.at(self.datetime)
    self.datetime = Time.at(self.datetime).strftime('%a %b %e, %Y at %I:%M %p')
  end
end