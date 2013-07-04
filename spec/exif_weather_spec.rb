require 'exif_weather'

describe ExifWeather do
  before do
    @no_gps = File.expand_path('../no_gps.jpg', __FILE__)
    @no_lat = File.expand_path('../no_lat.jpg', __FILE__)
    @no_lon = File.expand_path('../no_lon.jpg', __FILE__)
    @gps = File.expand_path('../gps.jpg', __FILE__)
  end

  describe ExifWeather::OpenWeather do
    it "shoud be nil when JPEG have no GPS info." do
      r = ExifWeather.weather(@no_gps)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be nil when JPEG have no latitude info." do
      r = ExifWeather.weather(@no_lat)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be nil when JPEG have no longitude info." do
      r = ExifWeather.weather(@no_lon)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be return hash when JPEG have GPS info." do
      r = ExifWeather.weather(@gps)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_an_instance_of(String)
      expect(r[:code]).to be_an_instance_of(Fixnum)
      expect(r[:desc]).to be_an_instance_of(String)
    end
  end

  describe ExifWeather::WorldWeatherOnline do
    before do
      @opt={:apikey=>ENV["WWO_API_KEY"], :service=>"worldweatheronline"}
    end
    it "shoud be raise error when no api-key." do
      expect{ExifWeather.weather(@no_gps, {:service=>"worldweatheronline"})}.to raise_error(RuntimeError)
      
    end
    it "shoud be nil when JPEG have no GPS info." do
      r = ExifWeather.weather(@no_gps, @opt)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be nil when JPEG have no latitude info." do
      r = ExifWeather.weather(@no_lat, @opt)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be nil when JPEG have no longitude info." do
      r = ExifWeather.weather(@no_lon, @opt)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_nil
      expect(r[:code]).to be_nil
      expect(r[:desc]).to be_nil
    end
    it "shoud be return hash when JPEG have GPS info." do
      r = ExifWeather.weather(@gps, @opt)
      expect(r).to be_an_instance_of(Hash)
      expect(r[:icon_url]).to be_an_instance_of(String)
      expect(r[:code]).to be_an_instance_of(Fixnum)
      expect(r[:desc]).to be_an_instance_of(String)
    end
  end
end
