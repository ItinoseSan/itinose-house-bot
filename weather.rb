require 'net/http'
require 'uri'
require 'json'

class Weather
  def initialize(api_key)
    @api_key = api_key
  end

  def current_weather(locate)
    end_point_url = 'http://api.openweathermap.org/data/2.5/weather'
    request_url = URI.parse (end_point_url + "?q=#{locate},jp&APPID=#{@api_key}")
    response = Net::HTTP.get(request_url)
    if response == "{\"cod\":\"404\",\"message\":\"city not found\"}"
      "Sorry! The location is not found."
    else
      json = JSON.parse(response)
      make_response(json,locate)
    end
  end

  def make_response(json,locate)
    temp = json['main']['temp']
    # convert to celsius
    celsius = temp - 273.15
    celsius_round = celsius.round(3)
    weather =  json['weather'][0]['main']
    "Current #{locate}'s weather is #{weather}. Temperature is #{celsius_round}℃"
  end
end