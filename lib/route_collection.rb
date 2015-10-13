module Roots
  class RouteCollection
    include Enumerable

    attr_reader :application_routes, :engine_routes

    def initialize(app_routes:, eng_routes: [])
      @application_routes = []
      @engine_routes = []

      app_engine_routes, _app_routes = app_routes.partition do |route|
        route.app.app.is_a?(Class) &&
          route.app.app.ancestors.include?(Rails::Engine)
      end

      app_engine_routes.each do |mount_route|
        name = mount_route.app.app.name
        add_route_to_array(engine_routes, mount_route, name)
      end

      _app_routes.each do |route|
        name = main_app_name
        add_route_to_array(application_routes, route, name)
      end

      eng_routes.each do |eng_hash|
        eng_hash[:routes].each do |route|
          name = eng_hash[:engine]
          add_route_to_array(engine_routes, route, name)
        end
      end
    end

    def attributes_for_display
      %w[name verb controller action path]
    end

    def add_route_to_array(array, route, name)
      wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
      return if wrapped.internal?

      if existing = array.find { |a| a[:app] == name }
        existing[:routes] << wrapped
      else
        array << { app: name, routes: [wrapped] }
      end
    end

    def each(&block)
      (app_routes + engine_routes).each(&block)
    end

    def main_app_name
      Rails.application.class.name
    end
  end
end
