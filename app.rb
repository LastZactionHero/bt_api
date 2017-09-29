require 'sinatra'
require 'rest-client'
require 'nokogiri'
require 'json'

get '/conditions' do
  flow_rate = fetch_flow_rate
  weather = fetch_weather

  content_type 'application/json'
  {
    temperature_f: weather[:temperature],
    weather_condition: weather[:text],
    flow_rate_cfs: flow_rate
  }.to_json
end

USGS_URL = 'http://waterdata.usgs.gov/co/nwis/uv/?site_no=06730200'.freeze

# Returns the flow rate of Boulder Creek, in Cubic Feet/Sec
def fetch_flow_rate
  response = RestClient.get(USGS_URL)
  body = Nokogiri::HTML(response.body)
  body_content = body.text  
  body_content.match(/(?<=Most recent instantaneous value: )[0-9\.]+/).to_s.to_f
end

WOE_ID = '2367231'.freeze
WEATHER_URL = "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%20#{WOE_ID}&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys".freeze


# Returns the weather conditiosn in Boulder
def fetch_weather
  response = RestClient.get(WEATHER_URL)
  body = JSON.parse(response.body)
  {
    text: body['query']['results']['channel']['item']['condition']['text'],
    temperature: body['query']['results']['channel']['item']['condition']['temp']
  }
end



