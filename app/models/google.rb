class Google

GOOGLE_API_BEG = 'https://maps.googleapis.com/maps/api/geocode/json?address='
GOOGLE_API_END = '&sensor=false&key=' + ENV["GOOGLE_API_KEY"]

GOOGLE_STREETVIEW_BEG = 'http://maps.googleapis.com/maps/api/streetview?size=300x300&location='
GOOGLE_STREETVIEW_END = '&heading=235&sensor=false'

  def self.find_latlon(street, zipcode)
    result = HTTParty.get(GOOGLE_API_BEG + street.gsub(/\W/, '+') + "+#{zipcode.to_i}" + GOOGLE_API_END)
    lat = result["results"].first["geometry"]["location"]["lat"]
    lng = result["results"].first["geometry"]["location"]["lng"]
    return GOOGLE_STREETVIEW_BEG + "#{lat},#{lng}" + GOOGLE_STREETVIEW_END
  end

end

