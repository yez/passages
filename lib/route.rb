module Roots
  class Route
    attr_reader :route_hash

    def initialize(route_hash)
      @route_hash = route_hash
      namespace_array, main_route_array = route_hash.partition { |r| r[:reqs] =~ /::/ }

      raise 'Main Route undefined' unless main_route_array.present?

      @namespace = namespace_array.first
      @main_route = main_route_array.first
    end

    def name
      @main_route[:name]
    end
  end
end
