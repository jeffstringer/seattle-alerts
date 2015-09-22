class SodaData

  attr_accessor :data_type

  def initialize(data_type)
    self.data_type = data_type
  end

  def fetch
    url = "#{api_url}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    JSON.parse(json)
  end

  def query
    timestamp = (Time.now - (60 * 60 * 24)).strftime('%F %H:%M:%S')
    api_url.include?('4ss6-4s75') ? query = "$where=datetime > '#{timestamp}'" : query = "$limit=1000"
  end

  def api_url
    if data_type.include?('fire')
      return 'http://data.seattle.gov/resource/4ss6-4s75.json'
    else
      return 'http://data.seattle.gov/resource/fw4z-a47w.json'
    end
  end
end