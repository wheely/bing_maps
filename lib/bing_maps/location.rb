module BingMaps
  class Location
    attr_reader :name, :point, :bbox, :entity_type, :address, :confidence
    
    def initialize(options={})
      @name = options['name']
      @point = options['point']
      @bbox = options['bbox']
      @entity_type = options['entityType']
      @address = options['address']
      @confidence = options['confidence']
    end
    
  end
end