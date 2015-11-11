require_relative 'route'

module Roots
  class RouteCollection
    include Enumerable

    attr_reader :routes

    def initialize(routes)
      @routes = []

      routes.each do |route|
        name = main_app_name
        add_route(route, name)
      end
    end

    def each(&block)
      Array(routes).each(&block)
    end

    private

    def add_route(route, name)
      wrapped = wrap_route(route)
      return if wrapped.nil?

      _route = Route.new(wrapped)
      _route.app_name = name
      @routes << _route
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
