require 'faraday'
require 'yajl'
require 'ap'

conn = Faraday.new(:url => 'http://api.crunchbase.com/v/1/') do |builder|
  builder.request  :url_encoded
  builder.request  :json
  builder.response :logger
  builder.adapter  :net_http
end

p = conn.get 'people.js'

parser = Yajl::Parser.new
j = parser.parse(p.body)

ap j

