require 'lib/route_collection'
require 'lib/engine_route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @routes = application_routes + engline_routes
    end

    private

    def engine_routes
      RouteCollection.new(
        ::Rails::Engine.subclasses.map do |engine|
          { engine: engine.name, routes: [*engine.routes.routes.routes] }
        end.flatten
      )
    end

    def application_routes
      EngineRouteCollection.new([*Rails.application.routes.routes])
    end
  end
end
