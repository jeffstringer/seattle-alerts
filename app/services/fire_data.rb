class FireData

  def fetch(api_url)
    timestamp = (Time.now - (60 * 60 * 24)).strftime('%F %H:%M:%S')
    query = "$where=datetime > '#{timestamp}'"
    url = "#{api_url}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    fire_alerts = JSON.parse(json)
  end
end