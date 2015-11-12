require_relative 'route'
require_relative 'route_collection'

module Roots
  class EngineRouteCollection < RouteCollection
    def initialize(engine_name, _routes)
      @routes = []
      _routes.each do |route|
        add_route(route, engine_name)
      end
    end
  end
end
