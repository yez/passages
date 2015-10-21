require_relative 'route'
require_relative 'engine_route'

module Roots
  class RouteCollection
    include Enumerable

    attr_reader :application_routes, :engine_routes

    def initialize(app_routes:, eng_routes: [])
      @application_routes = []
      @engine_routes = {}

      app_routes.each do |route|
        app_class = route.try(:app).try(:app)

        if app_class.is_a?(Class) && app_class.ancestors.include?(Rails::Engine)
          name = app_class.name
          add_engine_route(route, name, mount = true)
        else
          name = main_app_name
          add_route(route, name)
        end
      end

      eng_routes.each do |eng_hash|
        eng_hash[:routes].each do |route|
          name = eng_hash[:engine]
          add_engine_route(route, name)
        end
      end
    end

    def attributes_for_display
      %w[name verb controller action path]
    end

    def each(&block)
      (app_routes + engine_routes).each(&block)
    end

    private

    def add_route(route, name)
      wrapped = wrap_route(route)
      return if wrapped.nil?

      _route = Route.new(wrapped)
      _route.app_name = name
      @application_routes << _route
    end

    def add_engine_route(route, name, mount = false)
      wrapped = wrap_route(route)
      return if wrapped.nil?

      _route = EngineRoute.new(wrapped)
      _route.app_name = name
      _route.mount = mount
      @engine_routes[name] ||= []
      @engine_routes[name] << _route
    end

    def wrap_route(route)
      ActionDispatch::Routing::RouteWrapper.new(route).tap do |route|
        return nil if route.internal?
      end
    end

    def main_app_name
      Rails.application.class.name
    end
  end
end
