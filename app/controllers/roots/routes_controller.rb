require 'lib/mount_route'
require 'lib/route_collection'
require 'lib/engine_route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
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
      mount_routes, app_routes = Rails.application.routes.routes.partition(&method(:mount_route?))

      if mount_routes.present?
        @mount_routes = {}
        mount_routes.each do |route|
          mounted = MountRoute.new(route)
          @mount_routes[mounted.engine_name] = mounted unless mounted.internal?
        end
      end

      RouteCollection.new([*app_routes])
    end

    def mount_route?(route)
      app_class = route.try(:app).try(:app)
      app_class.is_a?(Class) && app_class.ancestors.include?(Rails::Engine)
    end
  end
end
