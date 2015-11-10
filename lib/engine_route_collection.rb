require_relative 'route'

module Roots
  class EngineRouteCollection
    include Enumerable

    attr_reader :routes

    def initialize(routes)
      @routes = {}
      routes.each do |route_hash|
        route_hash[:routes].each do |route|
          name = route_hash[:engine]
          add_route(route, name)
        end
      end
    end

    def each(&block)
      routes.each(&block)
    end

    private

    def add_route(route, name, mount = false)
      wrapped = wrap_route(route)
      return if wrapped.nil?

      routes[name] ||= {}

      _route = Route.new(wrapped)
      _route.app_name = name

      if mount
        routes[name][:mount] = _route
      else
        routes[name][:routes] ||= []
        routes[name][:routes] << _route
      end
    end

    def wrap_route(route)
      ActionDispatch::Routing::RouteWrapper.new(route).tap do |route|
        return nil if route.internal?
      end
    end
  end
end
