require_relative 'route'
require_relative 'route_collection'

module Passages
  # Specialized collection class inherited from RouteCollection specifically
  #  for routes of Engines (this Engine included)
  class EngineRouteCollection < RouteCollection
    def initialize(routes)
      @routes = routes.reject { |h| h[:routes].all?(&:internal?) }
    end
  end
end
