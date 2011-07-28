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
  
end