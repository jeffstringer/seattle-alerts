class FireAlertCleaner

  attr_accessor :address, :datetime, :incident_number, :longitude, :latitude, :type

  def initialize(options)
    @address = options["address"]
    @datetime = options["datetime"]
    @incident_number = options["incident_number"]
    @longitude = options["longitude"]
    @latitude = options["latitude"]
    @type = options["type"]
    self.set_time
  end 

  def set_time
    self.datetime = Time.at(self.datetime)
  end
end