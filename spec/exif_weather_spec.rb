require 'exif_weather'

describe ExifWeather do
  before do
    @no_gps = File.expand_path('../no_gps.jpg', __FILE__)
    @no_lat = File.expand_path('../no_lat.jpg', __FILE__)
    @no_lon = File.expand_path('../no_lon.jpg', __FILE__)
    @gps = File.expand_path('../gps.jpg', __FILE__)
  end

  it "shoud be nil when JPEG have no GPS info." do
    expect(ExifWeather.weather(@no_gps)).to be_nil
  end
  it "shoud be nil when JPEG have no latitude info." do
    expect(ExifWeather.weather(@no_lat)).to be_nil
  end
  it "shoud be nil when JPEG have no longitude info." do
    expect(ExifWeather.weather(@no_lon)).to be_nil
  end
  it "shoud be return hash when JPEG have GPS info." do
    expect(ExifWeather.weather(@gps)).to be_an_instance_of(Hash)
  end
end
