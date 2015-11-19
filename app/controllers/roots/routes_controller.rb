require 'lib/mount_route'
require 'lib/route_collection'
require 'lib/engine_route_collection'

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
      ::Rails::Engine.subclasses.map do |engine|
        _engine_routes = EngineRouteCollection.new(engine.name, [*engine.routes.routes.routes])
        next if _engine_routes.all?(&:internal?)

        { engine: engine.name, routes: _engine_routes }
      end.compact
    end

    def application_routes
      app_routes = []

      routes = roots_rails_routes.reject { route.is_a?(MountRoute) }

      RouteCollection.new(routes)
    end

    def roots_rails_routes
      @roots_rails_routes ||= Rails.application.routes.routes.map { |route| Route.new(route) }
    end

    def mount_routes
      {}.tap do |mount_routes|
        roots_rails_routes.each do |route|
          mount_routes[route.engine_name] = route if route.is_a?(MountRoute)
        end
      end
    end
  end
end
