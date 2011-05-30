require 'json'
require 'httparty'
require 'ap'
require 'mongo_mapper'



class CrunchBase
  include HTTParty
  format :json
  
  def self.query(query,page)
      t = get("http://api.crunchbase.com/v/1/search.js?query=#{query}&page=#{page}", :headers => {})       
  end
  
  def self.namespace(name)
    t = get("http://api.crunchbase.com/v/1/#{name}.js", :headers => {})
  end
  
  def self.entity(namespace, permalink)
    t = get("http://api.crunchbase.com/v/1/#{namespace}/#{permalink}.js")
  end
end


class Company
  include MongoMapper::Document

  
end


f = CrunchBase.entity('company', 'facebook')
c = Company.new f
puts c

