require 'em-http-request'
require 'em-synchrony/em-http'
require 'yajl/json_gem'

module BingMaps
  def self.new(options={})
    BingMaps::Client.new(options)
  end
end

require 'bing_maps/client'
require 'bing_maps/location'