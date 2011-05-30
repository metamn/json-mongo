require 'faraday'
require 'yajl'
require 'mongo_mapper'


MongoMapper.database = "test-1"
class Company
  include MongoMapper::Document
end

conn = Faraday.new(:url => 'http://api.crunchbase.com/v/1/') do |builder|
  builder.request  :url_encoded
  builder.request  :json
  builder.response :logger
  builder.adapter  :net_http
end



p = conn.get "company/aol.js"
parser = Yajl::Parser.new
j = parser.parse(p.body)

c = Company.new j
c.save


p = conn.get "company/google.js"
parser = Yajl::Parser.new
j = parser.parse(p.body)

c = Company.new j
c.save



# irb
# ---
# require 'mongo_mapper'
# MongoMapper.database = "test-1"
# class Company
#   include MongoMapper::Document
# end
# Company.all.map {|c| c.name}


# mongo // http://www.mongodb.org/display/DOCS/SQL+to+Mongo+Mapping+Chart
# ---
# use test-1
# show collections
# db.companies.find()
# db.companies.find({name:/Twitter/})




