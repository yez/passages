require_relative 'route'

module Roots
  class EngineRouteCollection
    include Enumerable

    attr_reader :routes

    def initialize(engine_name, _routes)
      _routes.each do |route|
        add_route(route, engine_name)
      end
    end

    def each(&block)
      Array(routes).each(&block)
    end

    private

    def add_route(route, name)
      @routes ||= []

      wrapped = wrap_route(route)
      return if wrapped.nil?

      _route = Route.new(wrapped)
      _route.app_name = name

      routes << _route
    end

    def wrap_route(route)
      ActionDispatch::Routing::RouteWrapper.new(route).tap do |route|
        return nil if route.internal?
      end
    end
  end
end
