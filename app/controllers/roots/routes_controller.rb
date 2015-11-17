require 'lib/mount_route'
require 'lib/route_collection'
require 'lib/engine_route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @mount_routes = {}
      @engine_routes = engine_routes
      @routes = application_routes
    end

    private

    def engine_routes
      ::Rails::Engine.subclasses.map do |engine|
        _engine_routes = EngineRouteCollection.new(engine.name, [*engine.routes.routes.routes])
        next if _engine_routes.all?(&:internal?)

        { engine: engine.name, routes: _engine_routes }
      end.compact
    end

    def application_routes
      app_routes = []

      Rails.application.routes.routes.each do |route|
        if mount_class = mount_route_class(route)
          mounted = MountRoute.new(route, mount_class)
          @mount_routes[mounted.engine_name] = mounted unless mounted.internal?
        else
          app_routes << route
        end
      end

      RouteCollection.new([*app_routes])
    end

    def mount_route_class(route)
      route_app = route.app

      app = if route_app.class == Class
        route_app
      else
        route_app.try(:app)
      end

      app if app.ancestors.include?(Rails::Engine)
    rescue
      false
    end
  end
end
