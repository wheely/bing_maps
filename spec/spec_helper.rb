require 'rubygems'
require 'bundler/setup'

require 'rack/test'
require 'rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'bing_maps')

RSpec.configure do |c|
  c.mock_with :rr
end