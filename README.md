[![Build Status](https://travis-ci.org/suzumura-ss/ExifWeather.png)](https://travis-ci.org/suzumura-ss/ExifWeather)

# ExifWeather

Get weather information via http://openweathermap.org/ based on GPS information of JPEG.


## Installation

Add this line to your application's Gemfile:

    gem 'exif_weather'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exif_weather

## Usage

    ExifWeather.weather( image_file_name )
    #=> Hash
    
### Example

    ExifWeather.weather('gps.jpg')
    #=>
    {"coord"=>{"lon"=>134.41, "lat"=>35.49},
      "sys"=>{"country"=>"JP", "sunrise"=>1372189731, "sunset"=>1372242103},
      "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10n"}],
      "base"=>"global stations",
      "main"=>{"temp"=>291.985, "temp_min"=>291.985, "temp_max"=>291.985,
        "pressure"=>973.1, "sea_level"=>1013.31, "grnd_level"=>973.1, "humidity"=>98},
      "wind"=>{"speed"=>1.85, "deg"=>356.503},
      "rain"=>{"3h"=>0.75},
      "clouds"=>{"all"=>92},
      "dt"=>1372255333,
      "id"=>1849892,
      "name"=>"Tottori",
      "cod"=>200
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
