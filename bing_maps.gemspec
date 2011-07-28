# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bing_maps/version"

Gem::Specification.new do |s|
  s.name        = "bing_maps"
  s.version     = BingMaps::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anton Chirkunov"]
  s.email       = ["anton@wheely.com"]
  s.homepage    = "http://wheely.com"
  s.summary     = %q{Bing Maps API wrapper}
  s.description = %q{Bing Maps API wrapper}

  #s.rubyforge_project = "wheely-cablifter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "em-http-request", '>= 1.0.0.beta.4'
  s.add_dependency "em-synchrony", '>= 0.3.0.beta.1'
  s.add_dependency "yajl-ruby"
end
