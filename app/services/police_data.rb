class PoliceData

  def initialize(api_url)
    @api_url = api_url
  end

  def fetch
    # query is limited to 1000 records by default, approximately 1 day
    query ="$limit=1000"
    url = "#{@api_url}?#{query}"
    url = URI.escape(url)
    json = open(url).read
    police_alerts = JSON.parse(json)
  end
end