About bing_maps
===================
bing_maps is an asychronous client to the Bing Maps API.

## Usage

    bing_maps = BingMaps::Client.new(:key => ENV['BING_MAPS_KEY'])
    bing_maps.callback {|locations| bing_maps_result = locations}
    bing_maps.errback  {|e| Toadhopper(ENV['AIRBRAKE_KEY']).post!(e)}
    bing_maps.query(q, 'countryRegion' => search_country_code))
