require 'lib/roots/route'
require 'lib/roots/engine_route'
require 'lib/roots/mount_route'
require 'lib/roots/route_collection'
require 'lib/roots/engine_route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @routes = application_routes
      @engine_routes = engine_routes
      @mount_routes = mount_routes
    end

    private

    def engine_routes
      EngineRouteCollection.new(mounted_engine_routes)
    end

    def application_routes
      routes = roots_rails_routes.reject { |route| route.is_a?(MountRoute) }

      RouteCollection.new(routes)
    end

    def mounted_engine_routes
      @mounted_engine_routes ||= ::Rails::Engine.subclasses.map do |engine|
        routes = engine.routes.routes.routes.map { |route| EngineRoute.new(route, engine.name) }

        { engine: engine.name, routes: routes }
      end.compact
    end

    def roots_rails_routes
      @roots_rails_routes ||= Rails.application.routes.routes.map { |route| Route.from_raw_route(route) }
    end

    def mount_routes
      {}.tap do |_mount_routes|
        roots_rails_routes.each do |route|
          _mount_routes[route.engine_name] = route if route.is_a?(MountRoute)
        end
      end
    end
  end
end
