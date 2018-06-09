require 'discordrb'
require './weather'

bot = Discordrb::Commands::CommandBot.new token:'API_TOKEN', client_id:'CLIENT_ID(integer)' , prefix: '!'


bot.command(:usage,permission_level:0) do |event|
  event.respond 'Please check this link. You can see greatly manual:)'
end

bot.command(:weather,permission_level:0) do |event, location|
  if location == nil
    event.respond 'ERROR!:please input location'
  else
    weather = Weather.new('API_KEY')
    event.respond(weather.current_weather(location))
  end
end

bot.command(:talk) do |event, context|

end

bot.command(:server_region,permission_level: 0) do |event|
  event.server.region
end

bot.run

