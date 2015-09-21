class SodaData

  def initialize(api_url)
    @api_url = api_url
  end

  def fetch
    url = "#{@api_url}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    JSON.parse(json)
  end

  def query
    timestamp = (Time.now - (60 * 60 * 24)).strftime('%F %H:%M:%S')
    @api_url.include?('4ss6-4s75') ? query = "$where=datetime > '#{timestamp}'" : query = "$limit=1000"
  end 
end