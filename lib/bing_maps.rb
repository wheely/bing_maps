require 'em-http-request'
require 'yajl-ruby/json_gem'

module BingMaps
  def self.new(options={})
    BingMaps::Client.new(options)
  end
end

require 'bing_maps/client'
require 'bing_maps/location'