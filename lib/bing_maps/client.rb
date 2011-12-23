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
    def reverse_geocode(ll, options={}, async = true)
      request("/Locations/#{ll}", {:query => {:key => @key}}, async)
    end

    # Gets a list of locations based on a query
    # @param [String] q A string that contains information about a location
    # @param [Hash] options Options
    # @param options [String] :c Use the culture parameter to specify a culture for your request
    # @param options [String] :userLocation The user's current position
    def query(q, options={}, async = true)
      request("/Locations", {:query => {:key => @key, :addressLine => q}.merge(options)}, async)
    end

    def request(url, opts, async)
      http = http_request(url, opts, async)
      http.errback { fail(Exception.new("An error occured in the HTTP request: #{http.errors}")) }
      http.callback do
        begin
          parsed = Yajl::Parser.parse(http.response)
          if parsed['resourceSets'] &&
             parsed['resourceSets'][0] &&
             parsed['resourceSets'][0]['resources']
            resources = parsed['resourceSets'][0]['resources']
            locations = resources.map{|data| BingMaps::Location.new(data)}
          else
            locations = []
          end

          if block_given?
            yield locations
          else
            succeed(locations)
          end
        rescue Exception => e
          fail(e)
        end
      end
      http
    end

    def http_request(url, opts, async)
      if async
        EventMachine::HttpRequest.new(@base_uri + url).aget(opts)
      else
        EventMachine::HttpRequest.new(@base_uri + url).get(opts)
      end
    end
  end
end
