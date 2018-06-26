require 'passages/route'
require 'passages/engine_route'
require 'passages/mount_route'
require 'passages/route_collection'
require 'passages/engine_route_collection'

module Passages
  # Single Rails controller responsible for
  #  collecting instance variables and rendering the Engine's main page
  class RoutesController < ActionController::Base
    layout false

    def routes
      @routes = application_routes
      @mount_routes = mount_routes
      mounted_engines = @mount_routes.keys
      @engine_routes = engine_routes.select do |r|
        mounted_engines.include?(r[:engine])
      end
    end

    private

    def engine_routes
      EngineRouteCollection.new(mounted_engine_routes)
    end

    def application_routes
      routes = passages_rails_routes.reject { |route| route.is_a?(MountRoute) }

      RouteCollection.new(routes)
    end

    def mounted_engine_routes
      @mounted_engine_routes ||= ::Rails::Engine.subclasses.map do |engine|
        routes = engine.routes.routes.routes.map do |route|
          EngineRoute.new(route, engine.name)
        end

        { engine: engine.name, routes: routes }
      end.compact
    end

    def passages_rails_routes
      @passages_rails_routes ||= Rails.application.routes.routes.map do |route|
        Route.from_raw_route(route)
      end
    end

    def mount_routes
      {}.tap do |mount_route_hash|
        passages_rails_routes.each do |route|
          mount_route_hash[route.engine_name] = route if route.is_a?(MountRoute)
        end
      end
    end
  end
end
