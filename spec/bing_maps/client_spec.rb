# encoding: utf-8
require 'spec_helper'

describe BingMaps::Client do
  before(:each) do
    @client = BingMaps.new(:key => ENV['BING_MAPS_KEY'])
  end

  it "should perform a reverse_geocode request" do
    result = nil
    EM.run {
      @client.callback do |locations|
        result = locations
        EM.stop
      end
      @client.reverse_geocode('48.218538,16.359950')
    }
    result.class.should == Array
  end

  it "should perform a query request" do
    result = nil
    EM.run {
      @client.callback do |locations|
        result = locations
        EM.stop
      end
      @client.query('Bahnhofstrasse, Zurich')
    }
    result.class.should == Array
  end

  describe "#query_with_geocoding" do
    it "allows user append some search data after point resolving" do
      result = []
      EM.synchrony do
        bing_maps = BingMaps::Client.new(:key => ENV['BING_MAPS_KEY'])
        bing_maps.callback do |locations|
          result = locations
          EM.stop
        end
        bing_maps.errback  {|e| puts e.message; pp e}

        bing_maps.query_with_geocoding("Tièchestrasse 9", "47.367347,8.550003") do |q, locations|
          location = locations.first
          country_code = location.address['countryRegion'] == "Switzerland" ? 'CH' : ''
          [q, {:countryRegion => country_code}]
        end
      end
      result.size.should > 0
    end
  end
end
