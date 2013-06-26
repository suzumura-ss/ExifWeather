require "exif_weather/version"
require 'exifr'
require 'open-uri'
require 'json'

module ExifWeather
  ##
  # Get weather information via http://openweathermap.org/
  # @param [String] file the JPEG image file with GPS information.
  # @return [Hash] weather information.
  def self.weather( file )
    e = EXIFR::JPEG.new(file)
    return nil unless e.gps
    lat = e.gps.latitude
    lon = e.gps.longitude
    return nil if lat.nil? or lon.nil?
    res = open("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}").read
    return JSON.parse(res)
  end
end
