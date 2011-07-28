module BingMaps
  class Client
    include EventMachine::Deferrable
    
    # Create a new BingMaps client
    #
    # @param [Hash] options Options
    # @option options [String] :key Your BingMaps API key
    def initialize(options={})
      @base_uri = 'http://dev.virtualearth.net/REST/v1'
      @key = options[:key]
      self
    end
    
    # Get an address for a specified point (latitude and longitude)
    # @param [String] ll Latitude and longitude
    # @param [Hash] options Options
    # @option options [String] :c The culture to use for the request
    def reverse_geocode(ll, options={})
      request("/Locations/#{ll}", :query => {:key => @key})
    end
    
    def query
    end
    
    def request(url, opts)
       http = http_request(url, opts)
       http.errback { fail }
       http.callback do
         parsed = Yajl::Parser.parse(http.response)
         resources = parsed['resourceSets'][0]['resources']
         locations = resources.map{|data| BingMaps::Location.new(data)}
         #parsed["response"]["groups"].each{|group| venues += group["items"]}
         succeed locations
       end
       http
     end

     def http_request(url, opts)
       EventMachine::HttpRequest.new(@base_uri + url).aget(opts)
     end
    
  end
end