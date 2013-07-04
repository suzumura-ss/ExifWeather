require "exif_weather/version"
require 'exifr'
require 'open-uri'
require 'json'

module ExifWeather
private

  class Weather
    attr_reader :lat, :lon, :date, :weather_info
    def initialize( file, opt={} )
      @opt = opt
      e = EXIFR::JPEG.new(file)
      if e.gps
        @lat = e.gps.latitude
        @lon = e.gps.longitude
      end
      @date = e.date_time_original
      @weather_info = weather
    end

    def weather
      url = req_url
      return nil if url.nil?
      res = open(url).read
      JSON.parse(res) if res
    end
  end

public
  ##
  # Get weather information via http://openweathermap.org/
  # @param [String] file the JPEG image file with GPS information.
  # @param [Hash] opt the Weather-API options.
  # @option :service [String] Weather service. "openweather"(default) or "worldweatheronline".
  # @option :apikey  [String] API-Key for "worldweatheronline".
  # @return [Hash] weather information.
  def self.weather( file, opt={} )
    w = (opt[:service]=="worldweatheronline") ? WorldWeatherOnline.new(file, opt) : OpenWeather.new(file, opt)
    {:icon_url=>w.icon_url, :code=>w.code, :desc=>w.desc}
  end


  class OpenWeather < Weather
    def req_url
      if @lat and @lon
        "http://api.openweathermap.org/data/2.5/weather?lat=#{@lat}&lon=#{@lon}"
      else
        nil
      end
    end

    ##
    # Get weather icon url.
    # @return [String] weather icon url.
    def icon_url
      begin
        "http://openweathermap.org/img/w/#{@weather_info['weather'][0]['icon']}.png"
      rescue NoMethodError=>e
        nil
      end
    end

    ##
    # Get weather code.
    # @return [Numeric] weather code.
    def code
      begin
        @weather_info['weather'][0]['id']
      rescue NoMethodError=>e
        nil
      end
    end

    ##
    # Get weather description.
    # @return [String] weather description.
    def desc
      begin
        @weather_info['weather'][0]['description']
      rescue NoMethodError=>e
        nil
      end
    end
  end


  class WorldWeatherOnline < Weather
    attr_reader :weather_all

    def req_url
      raise RuntimeError, ":apikey is required." unless @opt[:apikey]
      if @lat and @lon
        dq = @date ? @date.strftime('%Y-%m-%d')+"&" : ""
        "http://api.worldweatheronline.com/premium/v1/past-weather.ashx?q=#{@lat}%2C#{@lon}&#{dq}format=json&key=#{@opt[:apikey]}"
      else
        nil
      end
    end

    def weather
      @weather_all = super
      return nil if @weather_all.nil?
      photo_time = (@date || Time.now).strftime("%H%M").to_i
      times = @weather_all["data"]["weather"][0]["hourly"].map{|v| v["time"].to_i}
      times << 2400
      (0..(times.size-2)).each{|i|
        if times[i]<=photo_time and photo_time<times[i+1]
          @weather_info = @weather_all["data"]["weather"][0]["hourly"][i]
          return @weather_info
        end
      }
      raise RuntimeError, "Unknown state: photo-time:#{photo_time}, API-times:#{times}"
    end

    ##
    # Get weather icon url.
    # @return [String] weather icon url.
    def icon_url
      begin
        @weather_info['weatherIconUrl'][0]['value']
      rescue NoMethodError=>e
        nil
      end
    end

    ##
    # Get weather code.
    # @return [Numeric] weather code.
    def code
      begin
        @weather_info['weatherCode'].to_i
      rescue NoMethodError=>e
        nil
      end
    end

    ##
    # Get weather description.
    # @return [String] weather description.
    def desc
      begin
        @weather_info['weatherDesc'][0]['value']
      rescue NoMethodError=>e
        nil
      end
    end
  end
end
