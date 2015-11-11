require 'lib/route_collection'
require 'lib/engine_route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @routes = application_routes
      @engine_routes = engine_routes
    end

    private

    def engine_routes
      ::Rails::Engine.subclasses.map do |engine|
        { engine: engine.name, routes: EngineRouteCollection.new(engine.name, [*engine.routes.routes.routes]) }
      end.flatten
    end

    def application_routes
      RouteCollection.new([*Rails.application.routes.routes])
    end
  end
end
