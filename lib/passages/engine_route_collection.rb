require_relative 'route'
require_relative 'route_collection'

module Passages
  class EngineRouteCollection < RouteCollection
    def initialize(_routes)
      @routes = _routes.reject { |h| h[:routes].all?(&:internal?) }
    end
  end
end
